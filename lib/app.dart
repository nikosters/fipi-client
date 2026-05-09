import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'features/filters/presentation/filter_screen.dart';
import 'features/progress/presentation/progress_screen.dart';
import 'features/questions/presentation/question_session_screen.dart';
import 'features/subjects/presentation/subject_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SubjectScreen()),
      GoRoute(
        path: '/filters/:subjectId',
        builder: (context, state) =>
            FilterScreen(subjectId: state.pathParameters['subjectId']!),
      ),
      GoRoute(
        path: '/session/:subjectId',
        builder: (context, state) => QuestionSessionScreen(
          subjectId: state.pathParameters['subjectId']!,
        ),
      ),
      GoRoute(
        path: '/progress/:subjectId',
        builder: (context, state) =>
            ProgressScreen(subjectId: state.pathParameters['subjectId']!),
      ),
    ],
  );
});

class FipiApp extends ConsumerWidget {
  const FipiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'ФИПИ',
      theme: buildAppTheme(),
      darkTheme: buildAppTheme(),
      themeMode: ThemeMode.dark,
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
