import 'package:flutter_test/flutter_test.dart';

import 'package:fipi_client/features/questions/data/fipi_question_html_builder.dart';

void main() {
  const builder = FipiQuestionHtmlBuilder();

  test('builds WebView document with absolute MathJax and FIPI helpers', () {
    final html = builder.build('<div class="qblock"></div>');

    expect(
      html,
      contains('https://ege.fipi.ru/lib/mml/mathjax-4/mml-chtml.js'),
    );
    expect(html, contains('https://ege.fipi.ru/lib/mml/mathjax-4-config.js'));
    expect(html, contains('function ShowPictureQ'));
    expect(html, contains('function normalizeFipiUrl'));
    expect(html, contains('tr[bgcolor="#FFFFFF"]'));
    expect(html, contains('background: #ffffff !important'));
    expect(html, contains('background-color: #ffffff !important'));
    expect(html, isNot(contains('tui')));
    expect(html, isNot(contains('тёмн')));
  });

  test('normalizes runtime images with white backing', () {
    final html = builder.build('<div class="qblock"></div>');

    expect(
      html,
      contains("img.style.setProperty('background', '#fff', 'important');"),
    );
    expect(
      html,
      contains(
        "img.style.setProperty('background-color', '#fff', 'important');",
      ),
    );
    expect(
      html,
      contains(
        'style="background:#fff!important;background-color:#fff!important"',
      ),
    );
  });

  test('collects repeated answer fields as arrays', () {
    final html = builder.build('<form></form>');

    expect(html, contains('function addField'));
    expect(html, contains('data[name].push'));
    expect(html, contains("field.type === 'select-multiple'"));
    expect(html, contains('function formFor'));
    expect(html, contains('window.FipiSendAnswer'));
    expect(html, contains('setTimeout(function ()'));
    expect(html, contains('}, 120);'));
    expect(html, contains("field.dispatchEvent(new Event('change'"));
    expect(html, contains("target.closest('form')"));
    expect(html, contains("document.addEventListener('click'"));
    expect(
      html,
      contains('input[type="checkbox"], input[type="radio"], select, option'),
    );
  });

  test('keeps option marker and closing parenthesis together', () {
    final html = builder.build('<div class="qblock">1) Текст ответа</div>');

    expect(html, contains('.fipi-choice-marker-cell'));
    expect(html, contains('white-space: nowrap !important'));
    expect(html, contains('word-break: keep-all !important'));
    expect(html, contains('hyphens: none !important'));
    expect(html, contains('max-width: 2.2em !important'));
    expect(
      html,
      contains(
        '.qblock td:not(.fipi-answer-cell):not(.fipi-choice-marker-cell):not(.fipi-choice-control-cell)',
      ),
    );
    expect(html, contains('function normalizeOptionNumbers'));
    expect(html, contains('function compactOptionMarkerText'));
    expect(html, contains("replace(/[ \\t\\r\\n]+/g, '')"));
    expect(html, contains('element.textContent = marker'));
    expect(html, contains('input[type="checkbox"], input[type="radio"]'));
    expect(html, contains("input.closest && input.closest('tr')"));
    expect(html, contains('fipi-choice-control-cell'));
    expect(html, contains('fipi-choice-marker-cell'));
    expect(html, contains('fipi-choice-text-cell'));
    expect(html, contains('.fipi-choice-marker-cell br'));
    expect(html, contains('.fipi-option-marker br'));
    expect(html, contains('display: none !important'));
    expect(html, contains('part.replace'));
    expect(html, contains('node.classList.add'));
  });

  test('inlines ShowPictureQ docs image as FIPI root image', () {
    const fragment = '''
      <script language='javascript'>
        ShowPictureQ('docs/BA1F39653304A5B041B656915DC36B38/questions/x/image.png');
      </script>
    ''';

    final html = builder.build(fragment);

    expect(html, contains('ShowPictureQ'));
    expect(html, contains('https://ege.fipi.ru/docs/'));
    expect(
      html,
      contains(
        'src="https://ege.fipi.ru/docs/BA1F39653304A5B041B656915DC36B38/questions/x/image.png"',
      ),
    );
    expect(
      html,
      isNot(
        contains(
          "ShowPictureQ('docs/BA1F39653304A5B041B656915DC36B38/questions/x/image.png')",
        ),
      ),
    );
  });

  test('preserves FIPI copy suffix in root question image directories', () {
    final html = builder.build('''
      <script>
        ShowPictureQ('docs/BA1F39653304A5B041B656915DC36B38/questions/1312D9B057198D074C64EA6612C6DDDD(copy1)/xs3qstsrc1312D9B057198D074C64EA6612C6DDDD_7_1641891042.png');
      </script>
      <img src="docs/BA1F39653304A5B041B656915DC36B38/questions/1663B885A70CBB5548B711AE0B817523(copy3)/xs3qstsrc1663B885A70CBB5548B711AE0B817523_1_1667981733.gif">
    ''');

    expect(
      html,
      contains(
        'https://ege.fipi.ru/docs/BA1F39653304A5B041B656915DC36B38/questions/1312D9B057198D074C64EA6612C6DDDD(copy1)/xs3qstsrc1312D9B057198D074C64EA6612C6DDDD_7_1641891042.png',
      ),
    );
    expect(
      html,
      contains(
        'https://ege.fipi.ru/docs/BA1F39653304A5B041B656915DC36B38/questions/1663B885A70CBB5548B711AE0B817523(copy3)/xs3qstsrc1663B885A70CBB5548B711AE0B817523_1_1667981733.gif',
      ),
    );
    expect(html, contains('(copy1)'));
    expect(html, contains('(copy3)'));
  });

  test('inlines prefixed picture helper with hint alt text', () {
    final html = builder.build(
      '<script>parent.ShowPictureQ("/bank/docs/x.gif", "hint")</script>',
    );

    expect(html, contains('src="https://ege.fipi.ru/bank/docs/x.gif"'));
    expect(html, contains('alt="hint"'));
    expect(html, isNot(contains('parent.ShowPictureQ')));
  });

  test('inlines multiple FIPI pictures from one script', () {
    final html = builder.build('''
      <script>
        window.ShowPictureQ('docs/a.png');
        top.ShowPictureT2("lib/b.gif");
      </script>
    ''');

    expect(html, contains('src="https://ege.fipi.ru/docs/a.png"'));
    expect(html, contains('src="https://ege.fipi.ru/lib/b.gif"'));
    expect(RegExp(r'<img\b').allMatches(html).length, greaterThanOrEqualTo(2));
  });

  test('preserves namespaced MathML and schedules MathJax typesetting', () {
    const fragment = '''
      <m:math>
        <m:mstyle displaystyle="true">
          <m:semantics>
            <m:mrow>
              <m:mfrac><m:mi>a</m:mi><m:mi>b</m:mi></m:mfrac>
              <m:msub><m:mi>x</m:mi><m:mn>1</m:mn></m:msub>
            </m:mrow>
          </m:semantics>
        </m:mstyle>
      </m:math>
    ''';

    final html = builder.build(fragment);

    expect(html, contains('<m:math>'));
    expect(html, contains('<m:mfrac>'));
    expect(html, contains('<m:msub>'));
    expect(html, contains('function typesetMath'));
    expect(html, contains('function normalizeMathMl'));
    expect(html, contains('document.createTreeWalker'));
    expect(html, isNot(contains("querySelectorAll('m\\\\:math')")));
    expect(html, contains('http://www.w3.org/1998/Math/MathML'));
  });

  test('normalizes common FIPI image URL shapes', () {
    final html = builder.build('<div class="qblock"></div>');

    expect(html, contains('function fipiBankUrl'));
    expect(html, contains("var qfiles_location = 'https://ege.fipi.ru/';"));
    expect(html, contains("src.indexOf('/bank/') === 0"));
    expect(html, contains("src.indexOf('bank/') === 0"));
    expect(html, contains('ShowPictureQ(s, hint)'));
    expect(html, contains('writeImage(fipiBankUrl(s)'));
    expect(html, isNot(contains('stripFipiQuestionCopySuffix')));
  });

  test('inlines FIPI picture scripts before WebView execution', () {
    final html = builder.build('''
      <div class="qblock">
        <script>ShowPictureQ('/bank/docs/x/a.gif', 'x');</script>
        <script>ShowPictureT('lib/pic.png');</script>
      </div>
    ''');

    expect(html, contains('src="https://ege.fipi.ru/bank/docs/x/a.gif"'));
    expect(html, contains('alt="x"'));
    expect(html, contains('src="https://ege.fipi.ru/lib/pic.png"'));
    expect(html, isNot(contains("ShowPictureQ('/bank/docs/x/a.gif'")));
  });

  test('normalizes existing image tags as responsive FIPI images', () {
    final html = builder.build(
      '<img src="docs/x.png" width="600" height="400">',
    );

    expect(html, contains('src="https://ege.fipi.ru/docs/x.png"'));
    expect(
      html,
      contains(
        'style="max-width:100%;height:auto;background:#fff!important;background-color:#fff!important"',
      ),
    );
    expect(html, isNot(contains('width="600"')));
    expect(html, isNot(contains('height="400"')));
  });

  test('normalizes horizontal answer cells without nowrap table overflow', () {
    final html = builder.build(
      '<table><tr><td><input type="text" name="answer"> кДж</td></tr></table>',
    );

    expect(html, contains('function normalizeAnswerCells'));
    expect(html, contains('.fipi-answer-inline'));
    expect(html, contains('.fipi-answer-unit'));
    expect(
      html,
      isNot(contains('td:has(input[type="text"]) { white-space: nowrap; }')),
    );
  });

  test('includes debug-only image diagnostics markers', () {
    final html = builder.build(
      '<div class="qblock"><img src="docs/x.png"></div>',
    );

    expect(html, contains('[FIPI_IMG_ERROR]'));
    expect(html, contains('[FIPI_IMG_LOAD]'));
    expect(html, contains('[FIPI_IMG]'));
  });
}
