import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;

import '../domain/question_models.dart';
import 'fipi_question_html_builder.dart';

class FipiHtmlParser {
  FipiHtmlParser({FipiQuestionHtmlBuilder? htmlBuilder})
    : _htmlBuilder = htmlBuilder ?? const FipiQuestionHtmlBuilder();

  final FipiQuestionHtmlBuilder _htmlBuilder;

  List<TopicNode> parseTopics(String subjectId, String html) {
    final document = html_parser.parse(html);
    final nodes = <TopicNode>[];
    for (final input in document.querySelectorAll('input[name="theme"]')) {
      final code = input.attributes['value']?.trim();
      if (code == null || code.isEmpty) continue;
      final title = _labelText(input);
      nodes.add(
        TopicNode(
          id: '$subjectId:$code',
          subjectId: subjectId,
          code: code,
          title: title.isEmpty ? code : title,
          parentCode: parentCodeFor(code),
          depth: depthFor(code),
        ),
      );
    }
    return nodes;
  }

  List<AnswerKindOption> parseAnswerKinds(String html) {
    final document = html_parser.parse(html);
    return document
        .querySelectorAll('input[name="qkind"]')
        .map((input) {
          final code = input.attributes['value']?.trim() ?? '';
          return AnswerKindOption(
            code: code,
            title: _labelText(input),
            kind: answerKindFromCode(code),
          );
        })
        .where((option) => option.code.isNotEmpty)
        .toList();
  }

  QuestionPage parseQuestionPage({
    required String subjectId,
    required String html,
    required int page,
    required int pageSize,
    Map<String, QuestionStatus> localStatuses = const {},
  }) {
    final document = html_parser.parse(html);
    final totalCount = parseTotalCount(html);
    final blocks = document.querySelectorAll('.qblock');
    final questions = blocks
        .map((block) {
          final original = block.outerHtml;
          final guid =
              block.querySelector('input[name="guid"]')?.attributes['value'] ??
              _firstMatch(
                original,
                RegExp(r'''guid["']?\s*[:=]\s*["']([^"']+)'''),
              ) ??
              '';
          final shortNumber =
              _firstMatch(
                block.text,
                RegExp(r'Номер:\s*([0-9A-Za-zА-Яа-я_.-]+)'),
              ) ??
              guid;
          final topicCodes = RegExp(r'\b\d+(?:\.\d+){0,3}\b')
              .allMatches(block.querySelector('.task-info-content')?.text ?? '')
              .map((match) => match.group(0)!)
              .toSet()
              .toList();
          final answerKind = _kindFromText(block.text);
          return QuestionSummary(
            guid: guid,
            shortNumber: shortNumber,
            subjectId: subjectId,
            topicCodes: topicCodes,
            answerKind: answerKind,
            localStatus: localStatuses[guid] ?? QuestionStatus.unsolved,
            originalHtml: original,
            webViewHtml: _htmlBuilder.build(original),
          );
        })
        .where((question) => question.guid.isNotEmpty)
        .toList();
    return QuestionPage(
      totalCount: totalCount,
      page: page,
      pageSize: pageSize,
      questions: questions,
    );
  }

  int parseTotalCount(String html) {
    final raw = _firstMatch(html, RegExp(r'setQCount\((\d+)\)'));
    return int.tryParse(raw ?? '') ?? 0;
  }

  QuestionStatus statusFromSolveResponse(String response) {
    switch (response.trim()) {
      case '1':
        return QuestionStatus.solved;
      case '2':
        return QuestionStatus.wrong;
      case '3':
        return QuestionStatus.correct;
      default:
        return QuestionStatus.unsolved;
    }
  }

  static int depthFor(String code) => code.split('.').length;

  static String? parentCodeFor(String code) {
    final parts = code.split('.');
    if (parts.length == 1) return null;
    return parts.take(parts.length - 1).join('.');
  }

  static AnswerKind answerKindFromCode(String code) {
    return switch (code) {
      'ILI_STD_SELECTONE' => AnswerKind.selectOne,
      'ILI_STD_SELECTN' => AnswerKind.selectMany,
      'ILI_STD_SHORT' => AnswerKind.short,
      'ILI_STD_FULL' => AnswerKind.full,
      'ILI_EXT_ACCORD' => AnswerKind.accord,
      _ => AnswerKind.unknown,
    };
  }

  String _labelText(dom.Element input) {
    final parent = input.parent;
    if (parent?.localName == 'label') {
      return parent!.text.trim();
    }
    return input.nextElementSibling?.text.trim() ?? '';
  }

  String? _firstMatch(String source, RegExp pattern) =>
      pattern.firstMatch(source)?.group(1)?.trim();

  AnswerKind _kindFromText(String text) {
    if (text.contains('Выбор ответов')) return AnswerKind.selectMany;
    if (text.contains('Выбор ответа')) return AnswerKind.selectOne;
    if (text.contains('Краткий ответ')) return AnswerKind.short;
    if (text.contains('Развернутый ответ')) return AnswerKind.full;
    if (text.contains('Установление соответствия')) return AnswerKind.accord;
    return AnswerKind.unknown;
  }
}
