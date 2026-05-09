import 'package:flutter_test/flutter_test.dart';
import 'package:windows1251/windows1251.dart';

import 'package:fipi_client/features/questions/data/fipi_html_parser.dart';
import 'package:fipi_client/features/questions/data/fipi_repository.dart';
import 'package:fipi_client/features/questions/domain/question_models.dart';

void main() {
  test('decodes windows-1251 sample', () {
    expect(windows1251.decode([0xcf, 0xf0, 0xe8, 0xe2, 0xe5, 0xf2]), 'Привет');
  });

  test('computes topic depth and parent', () {
    expect(FipiHtmlParser.depthFor('1'), 1);
    expect(FipiHtmlParser.depthFor('1.1'), 2);
    expect(FipiHtmlParser.depthFor('1.1.1'), 3);
    expect(FipiHtmlParser.parentCodeFor('1'), isNull);
    expect(FipiHtmlParser.parentCodeFor('1.1'), '1');
    expect(FipiHtmlParser.parentCodeFor('1.1.1'), '1.1');
  });

  test('maps qkind codes', () {
    expect(
      FipiHtmlParser.answerKindFromCode('ILI_STD_SELECTONE'),
      AnswerKind.selectOne,
    );
    expect(
      FipiHtmlParser.answerKindFromCode('ILI_STD_SELECTN'),
      AnswerKind.selectMany,
    );
    expect(
      FipiHtmlParser.answerKindFromCode('ILI_STD_SHORT'),
      AnswerKind.short,
    );
    expect(FipiHtmlParser.answerKindFromCode('ILI_STD_FULL'), AnswerKind.full);
    expect(
      FipiHtmlParser.answerKindFromCode('ILI_EXT_ACCORD'),
      AnswerKind.accord,
    );
    expect(FipiHtmlParser.answerKindFromCode('x'), AnswerKind.unknown);
  });

  test('parses topics and answer kinds from start page html', () {
    final parser = FipiHtmlParser();
    const html = '''
      <label><input name="theme" value="1">Механика</label>
      <label><input name="theme" value="1.1">Кинематика</label>
      <label><input name="qkind" value="ILI_STD_SHORT">Краткий ответ</label>
    ''';
    final topics = parser.parseTopics('physics', html);
    final kinds = parser.parseAnswerKinds(html);
    expect(topics.map((topic) => topic.code), ['1', '1.1']);
    expect(topics.last.parentCode, '1');
    expect(kinds.single.kind, AnswerKind.short);
  });

  test('parses question summary and setQCount', () {
    final parser = FipiHtmlParser();
    const html = '''
      <script>window.parent.setQCount(12)</script>
      <div class="qblock">
        <input type="hidden" name="guid" value="abc">
        <div>Номер: <span class="canselect">123</span></div>
        <div class="task-info-content">КЭС 1.1 Краткий ответ</div>
        <form><input name="answer"></form>
      </div>
    ''';
    final page = parser.parseQuestionPage(
      subjectId: 'physics',
      html: html,
      page: 0,
      pageSize: 10,
    );
    expect(page.totalCount, 12);
    expect(page.questions.single.guid, 'abc');
    expect(page.questions.single.answerKind, AnswerKind.short);
    expect(
      page.questions.single.webViewHtml,
      contains('<base href="https://ege.fipi.ru/bank/">'),
    );
  });

  test('maps solve responses', () {
    final parser = FipiHtmlParser();
    expect(parser.statusFromSolveResponse('1'), QuestionStatus.solved);
    expect(parser.statusFromSolveResponse('2'), QuestionStatus.wrong);
    expect(parser.statusFromSolveResponse('3'), QuestionStatus.correct);
    expect(parser.statusFromSolveResponse('other'), QuestionStatus.unsolved);
  });

  test('builds question POST fields and filter hash', () {
    const filter = QuestionFilter(
      subjectId: 'physics',
      topicCodes: {'1.1', '1'},
      answerKinds: {AnswerKind.short},
      showSolved: false,
    );
    final fields = FipiRepository.buildQuestionFields(
      subjectId: 'physics',
      filter: filter,
      page: 2,
      pageSize: 10,
      solvedGuids: const ['a', 'b'],
    );
    expect(fields['theme'], '1,1.1');
    expect(fields['qkind'], 'ILI_STD_SHORT');
    expect(fields['solved'], '0:a,b');
    expect(fields['page'], '2');
    expect(FipiRepository.hashFilter(filter), isNotEmpty);
  });

  test('showSolved=false hides only solved and correct', () {
    const questions = [
      QuestionSummary(
        guid: 'a',
        shortNumber: '1',
        subjectId: 'physics',
        topicCodes: [],
        answerKind: AnswerKind.short,
        localStatus: QuestionStatus.unsolved,
        originalHtml: '',
        webViewHtml: '',
      ),
      QuestionSummary(
        guid: 'b',
        shortNumber: '2',
        subjectId: 'physics',
        topicCodes: [],
        answerKind: AnswerKind.short,
        localStatus: QuestionStatus.wrong,
        originalHtml: '',
        webViewHtml: '',
      ),
      QuestionSummary(
        guid: 'c',
        shortNumber: '3',
        subjectId: 'physics',
        topicCodes: [],
        answerKind: AnswerKind.short,
        localStatus: QuestionStatus.correct,
        originalHtml: '',
        webViewHtml: '',
      ),
    ];
    final visible = FipiRepository.excludeSolved(questions, {
      'a': QuestionStatus.solved,
      'b': QuestionStatus.wrong,
      'c': QuestionStatus.correct,
    });
    expect(visible.map((question) => question.guid), ['b']);
  });
}
