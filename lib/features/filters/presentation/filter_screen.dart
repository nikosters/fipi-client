import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../questions/data/providers.dart';
import '../../questions/domain/question_models.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key, required this.subjectId});

  final String subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(topicsProvider(subjectId));
    final kinds = ref.watch(answerKindsProvider(subjectId));
    final filter = ref.watch(selectionProvider(subjectId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Фильтры'),
        leading: IconButton(
          tooltip: 'Назад',
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            tooltip: 'Прогресс',
            onPressed: () => context.push('/progress/$subjectId'),
            icon: const Icon(Icons.checklist),
          ),
        ],
      ),
      body: topics.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorView(message: '$error'),
        data: (topicData) => kinds.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => _ErrorView(message: '$error'),
          data: (kindData) => Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ExpansionTile(
                      title: const Text('Темы'),
                      children: topicData
                          .map(
                            (node) =>
                                _TopicTile(node: node, allTopics: topicData),
                          )
                          .toList(),
                    ),
                    ExpansionTile(
                      title: const Text('Тип ответа'),
                      children: kindData
                          .map(
                            (kind) => CheckboxListTile(
                              value: filter.answerKinds.contains(kind.kind),
                              title: Text(kind.title),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (_) => ref
                                  .read(selectionProvider(subjectId).notifier)
                                  .toggleKind(kind.kind),
                            ),
                          )
                          .toList(),
                    ),
                    ExpansionTile(
                      title: const Text('Параметры'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: DropdownButtonFormField<int>(
                            initialValue: filter.questionCount,
                            decoration: const InputDecoration(
                              labelText: 'Количество вопросов',
                            ),
                            items: const [5, 10, 15, 20, 30, 50]
                                .map(
                                  (count) => DropdownMenuItem(
                                    value: count,
                                    child: Text('$count'),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              ref
                                  .read(selectionProvider(subjectId).notifier)
                                  .setQuestionCount(value);
                            },
                          ),
                        ),
                        SwitchListTile(
                          value: filter.showSolved,
                          title: const Text('Показывать решённые'),
                          onChanged: (value) => ref
                              .read(selectionProvider(subjectId).notifier)
                              .setShowSolved(value),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => context.push('/session/$subjectId'),
                      child: const Text('Начать подборку'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicTile extends ConsumerWidget {
  const _TopicTile({required this.node, required this.allTopics});

  final TopicNode node;
  final List<TopicNode> allTopics;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(selectionProvider(node.subjectId));
    final children = allTopics
        .where((candidate) => candidate.code.startsWith('${node.code}.'))
        .map((candidate) => candidate.code)
        .toList();
    final selectedChildren = children
        .where((code) => filter.topicCodes.contains(code))
        .length;
    final value =
        children.isNotEmpty &&
            selectedChildren > 0 &&
            selectedChildren < children.length
        ? null
        : filter.topicCodes.contains(node.code);
    return CheckboxListTile(
      value: value,
      tristate: true,
      dense: true,
      contentPadding: EdgeInsets.only(left: 16.0 * node.depth, right: 12),
      title: Text(node.title),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (_) => ref
          .read(selectionProvider(node.subjectId).notifier)
          .toggleTopic(node.code, allTopics),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}
