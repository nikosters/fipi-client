import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../subjects/data/initial_subjects.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = initialSubjects
        .where((subject) => subject.enabled)
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Предметы')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: subjects.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return Card(
            child: ListTile(
              title: Text(subject.title),
              subtitle: Text(subject.examGroup),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/filters/${subject.id}'),
            ),
          );
        },
      ),
    );
  }
}
