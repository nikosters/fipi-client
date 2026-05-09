import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../features/questions/domain/question_models.dart';

part 'app_database.g.dart';

class Subjects extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get examGroup => text().named('exam_group')();
  BoolColumn get enabled => boolean()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TopicNodeRow')
class TopicNodes extends Table {
  TextColumn get id => text()();
  TextColumn get subjectId => text().named('subject_id')();
  TextColumn get code => text()();
  TextColumn get title => text()();
  TextColumn get parentCode => text().named('parent_code').nullable()();
  IntColumn get depth => integer()();
  @override
  Set<Column> get primaryKey => {id};
}

class AnswerKindCache extends Table {
  TextColumn get id => text()();
  TextColumn get subjectId => text().named('subject_id')();
  TextColumn get code => text()();
  TextColumn get title => text()();
  TextColumn get kind => text()();
  DateTimeColumn get cachedAt => dateTime().named('cached_at')();
  @override
  Set<Column> get primaryKey => {id};
}

class QuestionCache extends Table {
  TextColumn get id => text()();
  TextColumn get subjectId => text().named('subject_id')();
  TextColumn get filterHash => text().named('filter_hash')();
  IntColumn get page => integer()();
  TextColumn get guid => text()();
  TextColumn get shortNumber => text().named('short_number')();
  TextColumn get answerKind => text().named('answer_kind')();
  TextColumn get topicCodesJson => text().named('topic_codes_json')();
  TextColumn get originalHtml => text().named('original_html')();
  DateTimeColumn get cachedAt => dateTime().named('cached_at')();
  @override
  Set<Column> get primaryKey => {id};
}

class SolvedQuestions extends Table {
  TextColumn get guid => text()();
  TextColumn get subjectId => text().named('subject_id')();
  TextColumn get status => text()();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
  @override
  Set<Column> get primaryKey => {guid};
}

class SelectionState extends Table {
  TextColumn get subjectId => text().named('subject_id')();
  TextColumn get topicCodesJson => text().named('topic_codes_json')();
  TextColumn get answerKindsJson => text().named('answer_kinds_json')();
  BoolColumn get showSolved => boolean().named('show_solved')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
  @override
  Set<Column> get primaryKey => {subjectId};
}

@DriftDatabase(
  tables: [
    Subjects,
    TopicNodes,
    AnswerKindCache,
    QuestionCache,
    SolvedQuestions,
    SelectionState,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'fipi_client'));

  @override
  int get schemaVersion => 1;

  Future<List<TopicNode>> cachedTopics(String subjectId) async {
    final rows =
        await (select(topicNodes)
              ..where((tbl) => tbl.subjectId.equals(subjectId))
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.code)]))
            .get();
    return rows
        .map(
          (row) => TopicNode(
            id: row.id,
            subjectId: row.subjectId,
            code: row.code,
            title: row.title,
            parentCode: row.parentCode,
            depth: row.depth,
          ),
        )
        .toList();
  }

  Future<void> replaceTopics(List<TopicNode> nodes) async {
    if (nodes.isEmpty) return;
    await batch((batch) {
      batch.deleteWhere(
        topicNodes,
        (tbl) => tbl.subjectId.equals(nodes.first.subjectId),
      );
      batch.insertAll(
        topicNodes,
        nodes.map(
          (node) => TopicNodesCompanion.insert(
            id: node.id,
            subjectId: node.subjectId,
            code: node.code,
            title: node.title,
            parentCode: Value(node.parentCode),
            depth: node.depth,
          ),
        ),
      );
    });
  }

  Future<List<String>> solvedForHiding(String subjectId) async {
    final rows =
        await (select(solvedQuestions)..where(
              (tbl) =>
                  tbl.subjectId.equals(subjectId) &
                  tbl.status.isIn([
                    QuestionStatus.solved.name,
                    QuestionStatus.correct.name,
                  ]),
            ))
            .get();
    return rows.map((row) => row.guid).toList();
  }

  Future<void> saveSolved(
    String subjectId,
    String guid,
    QuestionStatus status,
  ) async {
    final current = await (select(
      solvedQuestions,
    )..where((tbl) => tbl.guid.equals(guid))).getSingleOrNull();
    if (current != null) {
      final currentStatus = QuestionStatus.values.byName(current.status);
      if (_statusRank(currentStatus) > _statusRank(status)) return;
    }
    await into(solvedQuestions).insertOnConflictUpdate(
      SolvedQuestionsCompanion.insert(
        guid: guid,
        subjectId: subjectId,
        status: status.name,
        updatedAt: DateTime.now(),
      ),
    );
  }

  int _statusRank(QuestionStatus status) {
    return switch (status) {
      QuestionStatus.unsolved => 0,
      QuestionStatus.wrong => 1,
      QuestionStatus.solved => 2,
      QuestionStatus.correct => 3,
    };
  }

  Future<QuestionFilter?> loadSelectionFilter(String subjectId) async {
    final row = await (select(
      selectionState,
    )..where((tbl) => tbl.subjectId.equals(subjectId))).getSingleOrNull();
    if (row == null) return null;
    final topicPayload = parseTopicSelectionPayload(row.topicCodesJson);
    return QuestionFilter(
      subjectId: subjectId,
      topicCodes: topicPayload.topicCodes,
      answerKinds: (jsonDecode(row.answerKindsJson) as List)
          .cast<String>()
          .map((name) => AnswerKind.values.byName(name))
          .toSet(),
      showSolved: row.showSolved,
      questionCount: topicPayload.questionCount,
    );
  }

  Future<void> saveSelectionFilter(QuestionFilter filter) {
    return into(selectionState).insertOnConflictUpdate(
      SelectionStateCompanion.insert(
        subjectId: filter.subjectId,
        topicCodesJson: jsonEncode({
          'topicCodes': filter.topicCodes.toList()..sort(),
          'questionCount': filter.questionCount,
        }),
        answerKindsJson: jsonEncode(
          filter.answerKinds.map((kind) => kind.name).toList()..sort(),
        ),
        showSolved: filter.showSolved,
        updatedAt: DateTime.now(),
      ),
    );
  }

  static ({Set<String> topicCodes, int questionCount})
  parseTopicSelectionPayload(String value) {
    final decoded = jsonDecode(value);
    if (decoded is List) {
      return (topicCodes: decoded.cast<String>().toSet(), questionCount: 10);
    }
    if (decoded is Map) {
      final rawTopicCodes = decoded['topicCodes'];
      final rawQuestionCount = decoded['questionCount'];
      final questionCount =
          rawQuestionCount is int &&
              const {5, 10, 15, 20, 30, 50}.contains(rawQuestionCount)
          ? rawQuestionCount
          : 10;
      return (
        topicCodes: rawTopicCodes is List
            ? rawTopicCodes.map((code) => '$code').toSet()
            : <String>{},
        questionCount: questionCount,
      );
    }
    return (topicCodes: <String>{}, questionCount: 10);
  }
}
