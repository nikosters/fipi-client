import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../questions/data/providers.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key, required this.subjectId});

  final String subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Прогресс'),
        leading: IconButton(
          tooltip: 'Назад',
          onPressed: () => context.go('/filters/$subjectId'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: StreamBuilder(
        stream: (db.select(
          db.solvedQuestions,
        )..where((tbl) => tbl.subjectId.equals(subjectId))).watch(),
        builder: (context, snapshot) {
          final rows = snapshot.data ?? const [];
          if (rows.isEmpty) return const Center(child: Text('Пока пусто'));
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: rows.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final row = rows[index];
              return ListTile(
                title: Text(row.guid),
                subtitle: Text(row.status),
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: OutlinedButton(
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Сбросить отметки?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Отмена'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Сбросить'),
                    ),
                  ],
                ),
              );
              if (confirmed == true) {
                await (db.delete(
                  db.solvedQuestions,
                )..where((tbl) => tbl.subjectId.equals(subjectId))).go();
              }
            },
            child: const Text('Сбросить'),
          ),
        ),
      ),
    );
  }
}
