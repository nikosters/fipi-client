import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../data/answer_form_fields.dart';
import '../data/fipi_question_html_builder.dart';
import '../data/providers.dart';
import '../domain/question_models.dart';

class QuestionSessionScreen extends ConsumerStatefulWidget {
  const QuestionSessionScreen({super.key, required this.subjectId});

  final String subjectId;

  @override
  ConsumerState<QuestionSessionScreen> createState() =>
      _QuestionSessionScreenState();
}

class _QuestionSessionScreenState extends ConsumerState<QuestionSessionScreen> {
  int _index = 0;
  WebViewController? _controller;
  String? _loadedQuestionGuid;
  QuestionStatus _status = QuestionStatus.unsolved;
  late final QuestionPageRequest _request;

  @override
  void initState() {
    super.initState();
    final random = Random(DateTime.now().microsecondsSinceEpoch);
    _request = QuestionPageRequest(
      subjectId: widget.subjectId,
      page: random.nextInt(12),
      seed: random.nextInt(1 << 31),
    );
  }

  @override
  Widget build(BuildContext context) {
    final page = ref.watch(questionPageProvider(_request));
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) context.go('/filters/${widget.subjectId}');
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Подборка'),
          leading: IconButton(
            tooltip: 'Назад',
            onPressed: () => context.go('/filters/${widget.subjectId}'),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: page.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('$error', textAlign: TextAlign.center),
            ),
          ),
          data: (data) {
            if (data.questions.isEmpty) {
              return const Center(child: Text('Заданий нет'));
            }
            final currentIndex = _index.clamp(0, data.questions.length - 1);
            final question = data.questions[currentIndex];
            final status = _status == QuestionStatus.unsolved
                ? question.localStatus
                : _status;
            return Column(
              children: [
                _SessionBar(
                  question: question,
                  status: status,
                  index: currentIndex + 1,
                  total: data.questions.length,
                ),
                Expanded(
                  child: WebViewWidget(controller: _controllerFor(question)),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _next(data.questions.length),
                            child: const Text('Пропустить'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: _forceCheck,
                            child: const Text('Проверить'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _next(int total) {
    if (total == 0) return;
    setState(() {
      _index = (_index + 1) % total;
      _status = QuestionStatus.unsolved;
      _controller = null;
      _loadedQuestionGuid = null;
    });
  }

  void _nextAfterCorrect() {
    Future<void>.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      final page = ref.read(questionPageProvider(_request)).valueOrNull;
      if (page == null || page.questions.isEmpty) return;
      _next(page.questions.length);
    });
  }

  Future<void> _forceCheck() async {
    await _controller?.runJavaScript(
      'window.FipiSendAnswer && window.FipiSendAnswer();',
    );
  }

  WebViewController _controllerFor(QuestionSummary question) {
    final existing = _controller;
    if (existing != null) return existing;
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xff0b0f14))
      ..setOnConsoleMessage((message) {
        if (!kDebugMode) return;
        debugPrint(
          '[FIPI_WEBVIEW_CONSOLE] ${message.level.name}: ${message.message}',
        );
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            if (!kDebugMode) return;
            debugPrint(
              '[FIPI_WEBVIEW_RESOURCE_ERROR] '
              'code=${error.errorCode} '
              'type=${error.errorType} '
              'url=${error.url} '
              'description=${error.description}',
            );
          },
        ),
      )
      ..addJavaScriptChannel(
        'AnswerBridge',
        onMessageReceived: (message) => _check(question, message.message),
      );
    _controller = controller;
    _loadQuestionHtml(controller, question);
    return controller;
  }

  Future<void> _loadQuestionHtml(
    WebViewController controller,
    QuestionSummary question,
  ) async {
    final guid = question.guid;
    _loadedQuestionGuid = guid;
    try {
      final repository = await ref.read(fipiRepositoryProvider.future);
      final cookies = await repository.fipiCookies();
      final cookieManager = WebViewCookieManager();
      for (final cookie in cookies) {
        await cookieManager.setCookie(
          WebViewCookie(
            name: cookie.name,
            value: cookie.value,
            domain: 'ege.fipi.ru',
            path: cookie.path?.isNotEmpty == true ? cookie.path! : '/',
          ),
        );
      }
      if (kDebugMode) {
        debugPrint('[FIPI_WEBVIEW_COOKIE_SYNC] count=${cookies.length}');
      }
    } catch (error) {
      if (kDebugMode) {
        debugPrint('[FIPI_WEBVIEW_COOKIE_SYNC_ERROR] $error');
      }
    }
    if (!mounted || _controller != controller || _loadedQuestionGuid != guid) {
      return;
    }
    await controller.loadHtmlString(
      question.webViewHtml,
      baseUrl: 'https://ege.fipi.ru/bank/',
    );
  }

  Future<void> _check(QuestionSummary question, String payload) async {
    final decoded = jsonDecode(payload);
    if (decoded is! Map) return;
    final fields = flattenAnswerPayload(decoded);
    try {
      final repository = await ref.read(fipiRepositoryProvider.future);
      final result = await repository.checkAnswer(
        subjectId: widget.subjectId,
        questionGuid: question.guid,
        formFields: fields,
      );
      if (!mounted || _loadedQuestionGuid != question.guid) return;
      final status = _normalizeStatus(question, result.status);
      setState(() => _status = _bestStatus(_status, status));
      await _controller?.runJavaScript(
        const FipiQuestionHtmlBuilder().resultScript(status.name),
      );
      if (status == QuestionStatus.correct) {
        _nextAfterCorrect();
      }
      ref.invalidate(questionPageProvider(_request));
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Ошибка проверки')));
      }
    }
  }

  QuestionStatus _bestStatus(QuestionStatus current, QuestionStatus next) {
    return _statusRank(next) >= _statusRank(current) ? next : current;
  }

  QuestionStatus _normalizeStatus(
    QuestionSummary question,
    QuestionStatus status,
  ) {
    if (question.answerKind == AnswerKind.selectOne &&
        status == QuestionStatus.solved) {
      return QuestionStatus.correct;
    }
    return status;
  }

  int _statusRank(QuestionStatus status) {
    return switch (status) {
      QuestionStatus.unsolved => 0,
      QuestionStatus.wrong => 1,
      QuestionStatus.solved => 2,
      QuestionStatus.correct => 3,
    };
  }
}

class _SessionBar extends StatelessWidget {
  const _SessionBar({
    required this.question,
    required this.status,
    required this.index,
    required this.total,
  });

  final QuestionSummary question;
  final QuestionStatus status;
  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(status);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: status == QuestionStatus.unsolved
                ? Theme.of(context).colorScheme.outline
                : color,
            width: status == QuestionStatus.unsolved ? 1 : 2,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(child: Text('№ ${question.shortNumber}')),
          DecoratedBox(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.16),
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                _statusText(status),
                style: TextStyle(color: color, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text('$index/$total'),
        ],
      ),
    );
  }

  Color _statusColor(QuestionStatus status) {
    return switch (status) {
      QuestionStatus.unsolved => const Color(0xff9aa7b4),
      QuestionStatus.solved => const Color(0xff7db7ff),
      QuestionStatus.wrong => const Color(0xffff8a8a),
      QuestionStatus.correct => const Color(0xff69d28f),
    };
  }

  String _statusText(QuestionStatus status) {
    return switch (status) {
      QuestionStatus.unsolved => 'Не решено',
      QuestionStatus.solved => 'Решено',
      QuestionStatus.wrong => 'Неверно',
      QuestionStatus.correct => 'Верно',
    };
  }
}
