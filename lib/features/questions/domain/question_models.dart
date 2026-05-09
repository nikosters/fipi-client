class Subject {
  const Subject({
    required this.id,
    required this.title,
    required this.examGroup,
    required this.enabled,
  });

  final String id;
  final String title;
  final String examGroup;
  final bool enabled;
}

class TopicNode {
  const TopicNode({
    required this.id,
    required this.subjectId,
    required this.code,
    required this.title,
    required this.parentCode,
    required this.depth,
  });

  final String id;
  final String subjectId;
  final String code;
  final String title;
  final String? parentCode;
  final int depth;
}

enum AnswerKind { selectOne, selectMany, short, full, accord, unknown }

class AnswerKindOption {
  const AnswerKindOption({
    required this.code,
    required this.title,
    required this.kind,
  });

  final String code;
  final String title;
  final AnswerKind kind;
}

class QuestionFilter {
  const QuestionFilter({
    required this.subjectId,
    required this.topicCodes,
    required this.answerKinds,
    required this.showSolved,
    this.questionCount = 10,
  });

  final String subjectId;
  final Set<String> topicCodes;
  final Set<AnswerKind> answerKinds;
  final bool showSolved;
  final int questionCount;

  QuestionFilter copyWith({
    Set<String>? topicCodes,
    Set<AnswerKind>? answerKinds,
    bool? showSolved,
    int? questionCount,
  }) {
    return QuestionFilter(
      subjectId: subjectId,
      topicCodes: topicCodes ?? this.topicCodes,
      answerKinds: answerKinds ?? this.answerKinds,
      showSolved: showSolved ?? this.showSolved,
      questionCount: questionCount ?? this.questionCount,
    );
  }
}

class QuestionSummary {
  const QuestionSummary({
    required this.guid,
    required this.shortNumber,
    required this.subjectId,
    required this.topicCodes,
    required this.answerKind,
    required this.localStatus,
    required this.originalHtml,
    required this.webViewHtml,
  });

  final String guid;
  final String shortNumber;
  final String subjectId;
  final List<String> topicCodes;
  final AnswerKind answerKind;
  final QuestionStatus localStatus;
  final String originalHtml;
  final String webViewHtml;
}

enum QuestionStatus { unsolved, solved, wrong, correct }

class CheckAnswerResult {
  const CheckAnswerResult({required this.questionGuid, required this.status});

  final String questionGuid;
  final QuestionStatus status;
}

class QuestionPage {
  const QuestionPage({
    required this.totalCount,
    required this.page,
    required this.pageSize,
    required this.questions,
  });

  final int totalCount;
  final int page;
  final int pageSize;
  final List<QuestionSummary> questions;
}
