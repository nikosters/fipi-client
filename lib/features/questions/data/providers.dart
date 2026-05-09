import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/fipi_http_client.dart';
import '../../../core/storage/app_database.dart';
import '../domain/question_models.dart';
import 'fipi_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

final httpClientProvider = FutureProvider<FipiHttpClient>((ref) {
  return FipiHttpClient.create();
});

final fipiRepositoryProvider = FutureProvider<FipiRepository>((ref) async {
  final http = await ref.watch(httpClientProvider.future);
  return FipiRepository(
    httpClient: http,
    database: ref.watch(databaseProvider),
  );
});

final topicsProvider = FutureProvider.family<List<TopicNode>, String>((
  ref,
  subjectId,
) async {
  final repository = await ref.watch(fipiRepositoryProvider.future);
  return repository.loadTopics(subjectId);
});

final answerKindsProvider =
    FutureProvider.family<List<AnswerKindOption>, String>((
      ref,
      subjectId,
    ) async {
      final repository = await ref.watch(fipiRepositoryProvider.future);
      return repository.loadAnswerKinds(subjectId);
    });

final selectionProvider =
    StateNotifierProvider.family<SelectionController, QuestionFilter, String>(
      (ref, subjectId) => SelectionController(ref, subjectId),
    );

class SelectionController extends StateNotifier<QuestionFilter> {
  SelectionController(this._ref, this.subjectId)
    : super(
        QuestionFilter(
          subjectId: subjectId,
          topicCodes: const {},
          answerKinds: const {},
          showSolved: false,
        ),
      ) {
    _load();
  }

  final Ref _ref;
  final String subjectId;

  Future<void> _load() async {
    final repository = await _ref.read(fipiRepositoryProvider.future);
    final saved = await repository.loadSelection(subjectId);
    if (saved != null) state = saved;
  }

  Future<void> setFilter(QuestionFilter filter) async {
    state = filter;
    final repository = await _ref.read(fipiRepositoryProvider.future);
    await repository.saveSelection(filter);
  }

  Future<void> toggleTopic(String code, List<TopicNode> allTopics) {
    final selected = {...state.topicCodes};
    final codes = allTopics
        .where((node) => node.code == code || node.code.startsWith('$code.'))
        .map((node) => node.code);
    final shouldSelect = !selected.contains(code);
    if (shouldSelect) {
      selected.addAll(codes);
    } else {
      selected.removeAll(codes);
    }
    return setFilter(state.copyWith(topicCodes: selected));
  }

  Future<void> toggleKind(AnswerKind kind) {
    final selected = {...state.answerKinds};
    selected.contains(kind) ? selected.remove(kind) : selected.add(kind);
    return setFilter(state.copyWith(answerKinds: selected));
  }

  Future<void> setShowSolved(bool value) =>
      setFilter(state.copyWith(showSolved: value));

  Future<void> setQuestionCount(int value) =>
      setFilter(state.copyWith(questionCount: value));
}

class QuestionPageRequest {
  const QuestionPageRequest({
    required this.subjectId,
    required this.page,
    required this.seed,
  });

  final String subjectId;
  final int page;
  final int seed;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionPageRequest &&
          runtimeType == other.runtimeType &&
          subjectId == other.subjectId &&
          page == other.page &&
          seed == other.seed;

  @override
  int get hashCode => Object.hash(subjectId, page, seed);
}

final questionPageProvider =
    FutureProvider.family<QuestionPage, QuestionPageRequest>((
      ref,
      request,
    ) async {
      final repository = await ref.watch(fipiRepositoryProvider.future);
      final filter = ref.watch(selectionProvider(request.subjectId));
      var page = await repository.loadQuestions(
        subjectId: request.subjectId,
        filter: filter,
        page: request.page,
        pageSize: filter.questionCount,
      );
      if (page.questions.isEmpty && request.page != 0) {
        page = await repository.loadQuestions(
          subjectId: request.subjectId,
          filter: filter,
          page: 0,
          pageSize: filter.questionCount,
        );
      }
      final questions = [...page.questions]..shuffle(Random(request.seed));
      return QuestionPage(
        totalCount: page.totalCount,
        page: page.page,
        pageSize: page.pageSize,
        questions: questions,
      );
    });
