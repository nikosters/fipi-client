import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';

import '../../../core/network/fipi_endpoints.dart';
import '../../../core/network/fipi_http_client.dart';
import '../../../core/storage/app_database.dart';
import '../domain/question_models.dart';
import 'fipi_html_parser.dart';
import 'fipi_question_html_builder.dart';

class FipiRepository {
  FipiRepository({
    required FipiHttpClient httpClient,
    required AppDatabase database,
    FipiHtmlParser? parser,
  }) : _http = httpClient,
       _db = database,
       _parser = parser ?? FipiHtmlParser();

  final FipiHttpClient _http;
  final AppDatabase _db;
  final FipiHtmlParser _parser;

  Future<List<Cookie>> fipiCookies() => _http.fipiCookies();

  Future<List<TopicNode>> loadTopics(String subjectId) async {
    try {
      final html = await _http.getHtml(FipiEndpoints.index, {
        'proj': subjectId,
      });
      final topics = _parser.parseTopics(subjectId, html);
      await _db.replaceTopics(topics);
      return topics;
    } catch (_) {
      final cached = await _db.cachedTopics(subjectId);
      if (cached.isNotEmpty) return cached;
      rethrow;
    }
  }

  Future<List<AnswerKindOption>> loadAnswerKinds(String subjectId) async {
    try {
      final html = await _http.getHtml(FipiEndpoints.index, {
        'proj': subjectId,
      });
      final kinds = _parser.parseAnswerKinds(html);
      await _replaceAnswerKinds(subjectId, kinds);
      return kinds;
    } catch (_) {
      final rows = await (_db.select(
        _db.answerKindCache,
      )..where((tbl) => tbl.subjectId.equals(subjectId))).get();
      if (rows.isNotEmpty) {
        return rows
            .map(
              (row) => AnswerKindOption(
                code: row.code,
                title: row.title,
                kind: AnswerKind.values.byName(row.kind),
              ),
            )
            .toList();
      }
      rethrow;
    }
  }

  Future<QuestionPage> loadQuestions({
    required String subjectId,
    required QuestionFilter filter,
    required int page,
    int pageSize = 10,
  }) async {
    final filterHash = hashFilter(filter);
    try {
      final solved = filter.showSolved
          ? <String>[]
          : await _db.solvedForHiding(subjectId);
      final html = await _http.postForm(
        FipiEndpoints.questions,
        buildQuestionFields(
          subjectId: subjectId,
          filter: filter,
          page: page,
          pageSize: pageSize,
          solvedGuids: solved.length <= 150 ? solved : const [],
        ),
      );
      final statuses = await _statusMap(subjectId);
      final parsed = _parser.parseQuestionPage(
        subjectId: subjectId,
        html: html,
        page: page,
        pageSize: pageSize,
        localStatuses: statuses,
      );
      final visible = filter.showSolved
          ? parsed.questions
          : excludeSolved(parsed.questions, statuses);
      final visibleWithImages = await _inlineWebViewImages(visible);
      await _replaceQuestionCache(
        subjectId: subjectId,
        filterHash: filterHash,
        page: page,
        questions: parsed.questions,
      );
      return QuestionPage(
        totalCount: parsed.totalCount,
        page: page,
        pageSize: pageSize,
        questions: visibleWithImages,
      );
    } catch (_) {
      final cached = await _cachedQuestions(
        subjectId,
        filterHash,
        page,
        pageSize,
      );
      if (cached.questions.isNotEmpty) return cached;
      rethrow;
    }
  }

  Future<CheckAnswerResult> checkAnswer({
    required String subjectId,
    required String questionGuid,
    required Map<String, String> formFields,
  }) async {
    Future<String> send() async {
      await _http.getHtml(FipiEndpoints.questions, {
        'proj': subjectId,
        'init_filter_themes': '1',
      });
      return _http.postForm(FipiEndpoints.solve, {
        ...formFields,
        'guid': questionGuid,
        'proj': subjectId,
      });
    }

    var response = await send();
    var status = _parser.statusFromSolveResponse(response);
    if (status == QuestionStatus.unsolved) {
      response = await send();
      status = _parser.statusFromSolveResponse(response);
    }
    if (status == QuestionStatus.unsolved) {
      throw StateError('Unexpected solve.php response: $response');
    }
    await _db.saveSolved(subjectId, questionGuid, status);
    return CheckAnswerResult(questionGuid: questionGuid, status: status);
  }

  Future<void> saveSelection(QuestionFilter filter) =>
      _db.saveSelectionFilter(filter);

  Future<QuestionFilter?> loadSelection(String subjectId) =>
      _db.loadSelectionFilter(subjectId);

  static Map<String, String> buildQuestionFields({
    required String subjectId,
    required QuestionFilter filter,
    required int page,
    required int pageSize,
    List<String> solvedGuids = const [],
  }) {
    return {
      'search': '1',
      'pagesize': '$pageSize',
      'proj': subjectId,
      'theme': (filter.topicCodes.toList()..sort()).join(','),
      'qkind': filter.answerKinds
          .map(answerKindCode)
          .where((e) => e.isNotEmpty)
          .join(','),
      'qlevel': '',
      'qsstruct': '',
      'qpos': '',
      'qid': '',
      'zid': '',
      'solved': filter.showSolved || solvedGuids.isEmpty
          ? ''
          : '0:${solvedGuids.join(',')}',
      'favorite': '',
      'blind': '',
      'page': '$page',
    };
  }

  static String answerKindCode(AnswerKind kind) {
    return switch (kind) {
      AnswerKind.selectOne => 'ILI_STD_SELECTONE',
      AnswerKind.selectMany => 'ILI_STD_SELECTN',
      AnswerKind.short => 'ILI_STD_SHORT',
      AnswerKind.full => 'ILI_STD_FULL',
      AnswerKind.accord => 'ILI_EXT_ACCORD',
      AnswerKind.unknown => '',
    };
  }

  static String hashFilter(QuestionFilter filter) {
    final topics = filter.topicCodes.toList()..sort();
    final kinds = filter.answerKinds.map((kind) => kind.name).toList()..sort();
    return sha1
        .convert(
          utf8.encode(
            jsonEncode([filter.subjectId, topics, kinds, filter.showSolved]),
          ),
        )
        .toString();
  }

  static List<QuestionSummary> excludeSolved(
    List<QuestionSummary> questions,
    Map<String, QuestionStatus> statuses,
  ) {
    return questions.where((question) {
      final status = statuses[question.guid] ?? question.localStatus;
      return status != QuestionStatus.solved &&
          status != QuestionStatus.correct;
    }).toList();
  }

  Future<void> _replaceAnswerKinds(
    String subjectId,
    List<AnswerKindOption> kinds,
  ) async {
    await _db.batch((batch) {
      batch.deleteWhere(
        _db.answerKindCache,
        (tbl) => tbl.subjectId.equals(subjectId),
      );
      batch.insertAll(
        _db.answerKindCache,
        kinds.map(
          (kind) => AnswerKindCacheCompanion.insert(
            id: '$subjectId:${kind.code}',
            subjectId: subjectId,
            code: kind.code,
            title: kind.title,
            kind: kind.kind.name,
            cachedAt: DateTime.now(),
          ),
        ),
      );
    });
  }

  Future<Map<String, QuestionStatus>> _statusMap(String subjectId) async {
    final rows = await (_db.select(
      _db.solvedQuestions,
    )..where((tbl) => tbl.subjectId.equals(subjectId))).get();
    return {
      for (final row in rows)
        row.guid: QuestionStatus.values.byName(row.status),
    };
  }

  Future<void> _replaceQuestionCache({
    required String subjectId,
    required String filterHash,
    required int page,
    required List<QuestionSummary> questions,
  }) async {
    await _db.batch((batch) {
      batch.deleteWhere(
        _db.questionCache,
        (tbl) =>
            tbl.subjectId.equals(subjectId) &
            tbl.filterHash.equals(filterHash) &
            tbl.page.equals(page),
      );
      batch.insertAll(
        _db.questionCache,
        questions.map(
          (question) => QuestionCacheCompanion.insert(
            id: '$filterHash:$page:${question.guid}',
            subjectId: subjectId,
            filterHash: filterHash,
            page: page,
            guid: question.guid,
            shortNumber: question.shortNumber,
            answerKind: question.answerKind.name,
            topicCodesJson: jsonEncode(question.topicCodes),
            originalHtml: question.originalHtml,
            cachedAt: DateTime.now(),
          ),
        ),
      );
    });
  }

  Future<QuestionPage> _cachedQuestions(
    String subjectId,
    String filterHash,
    int page,
    int pageSize,
  ) async {
    final rows =
        await (_db.select(_db.questionCache)..where(
              (tbl) =>
                  tbl.subjectId.equals(subjectId) &
                  tbl.filterHash.equals(filterHash) &
                  tbl.page.equals(page),
            ))
            .get();
    final statuses = await _statusMap(subjectId);
    final builder = const FipiQuestionHtmlBuilder();
    final questions = rows
        .map(
          (row) => QuestionSummary(
            guid: row.guid,
            shortNumber: row.shortNumber,
            subjectId: row.subjectId,
            topicCodes: (jsonDecode(row.topicCodesJson) as List).cast<String>(),
            answerKind: AnswerKind.values.byName(row.answerKind),
            localStatus: statuses[row.guid] ?? QuestionStatus.unsolved,
            originalHtml: row.originalHtml,
            webViewHtml: builder.build(row.originalHtml),
          ),
        )
        .toList();
    return QuestionPage(
      totalCount: rows.length,
      page: page,
      pageSize: pageSize,
      questions: await _inlineWebViewImages(questions),
    );
  }

  Future<List<QuestionSummary>> _inlineWebViewImages(
    List<QuestionSummary> questions,
  ) {
    return Future.wait(questions.map(_inlineQuestionWebViewImages));
  }

  Future<QuestionSummary> _inlineQuestionWebViewImages(
    QuestionSummary question,
  ) async {
    final urls = RegExp(
      r'''<img\b[^>]*\bsrc="(https://ege\.fipi\.ru/[^"]+)''',
      caseSensitive: false,
    ).allMatches(question.webViewHtml).map((match) => match.group(1)!).toSet();
    if (urls.isEmpty) return question;

    var html = question.webViewHtml;
    for (final url in urls) {
      try {
        final image = await _http.getBinaryUrl(url);
        if (image.bytes.isEmpty) continue;
        final mimeType = _imageMimeType(url, image.contentType);
        final dataUrl = 'data:$mimeType;base64,${base64Encode(image.bytes)}';
        html = html.replaceAll(url, dataUrl);
        if (kDebugMode) {
          debugPrint(
            '[FIPI_IMG_INLINE] url=$url bytes=${image.bytes.length} type=$mimeType',
          );
        }
      } catch (error) {
        if (kDebugMode) {
          debugPrint('[FIPI_IMG_INLINE_ERROR] url=$url error=$error');
        }
      }
    }
    if (identical(html, question.webViewHtml)) return question;
    return QuestionSummary(
      guid: question.guid,
      shortNumber: question.shortNumber,
      subjectId: question.subjectId,
      topicCodes: question.topicCodes,
      answerKind: question.answerKind,
      localStatus: question.localStatus,
      originalHtml: question.originalHtml,
      webViewHtml: html,
    );
  }

  String _imageMimeType(String url, String? contentType) {
    final normalized = contentType?.split(';').first.trim().toLowerCase();
    if (normalized != null && normalized.startsWith('image/')) {
      return normalized;
    }
    final path = Uri.tryParse(url)?.path.toLowerCase() ?? url.toLowerCase();
    if (path.endsWith('.jpg') || path.endsWith('.jpeg')) return 'image/jpeg';
    if (path.endsWith('.gif')) return 'image/gif';
    if (path.endsWith('.svg')) return 'image/svg+xml';
    if (path.endsWith('.webp')) return 'image/webp';
    return 'image/png';
  }
}
