import 'dart:convert';

class FipiQuestionHtmlBuilder {
  const FipiQuestionHtmlBuilder();

  String build(String originalHtml) {
    final preparedHtml = _normalizeImageTags(
      _inlineFipiScriptPictures(originalHtml),
    );
    return '''
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <base href="https://ege.fipi.ru/bank/">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script>
    window.MathJax = window.MathJax || {
      options: {
        ignoreHtmlClass: 'tex2jax_ignore',
        processHtmlClass: 'tex2jax_process'
      },
      startup: {
        typeset: false
      }
    };
  </script>
  <script src="https://ege.fipi.ru/lib/mml/mathjax-4-config.js"></script>
  <script src="https://ege.fipi.ru/lib/mml/mathjax-4/mml-chtml.js"></script>
  <script>
    var qfiles_location = 'https://ege.fipi.ru/';
    var files_location = 'https://ege.fipi.ru/';
    var files_abs_location = 'https://ege.fipi.ru/';

    function normalizeFipiUrl(src) {
      var url = new URL(src, document.baseURI);
      if (url.hostname.endsWith('fipi.ru') && url.protocol === 'http:') {
        url.protocol = 'https:';
      }
      return url.href;
    }

    function fipiBankUrl(src) {
      src = String(src || '');
      if (/^https?:[/][/]/i.test(src)) return normalizeFipiUrl(src);
      if (src.indexOf('/bank/') === 0) return normalizeFipiUrl('https://ege.fipi.ru' + src);
      if (src.indexOf('bank/') === 0) return normalizeFipiUrl('https://ege.fipi.ru/' + src);
      if (src.charAt(0) === '/') return normalizeFipiUrl('https://ege.fipi.ru' + src);
      return normalizeFipiUrl(qfiles_location + src);
    }

    function fipiRootUrl(src) {
      src = String(src || '');
      if (/^https?:[/][/]/i.test(src)) return normalizeFipiUrl(src);
      if (src.charAt(0) === '/') return normalizeFipiUrl('https://ege.fipi.ru' + src);
      return normalizeFipiUrl(files_location + src);
    }

    function escapeFipiAttr(value) {
      return String(value || '')
        .replace(/&/g, '&amp;')
        .replace(/"/g, '&quot;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;');
    }

    function writeImage(src, attrs) {
      document.write('<img src="' + escapeFipiAttr(normalizeFipiUrl(src)) + '" style="background:#fff!important;background-color:#fff!important" ' + (attrs || '') + '>');
    }

    function ShowPictureQ(s, hint) {
      writeImage(fipiBankUrl(s), 'align="absmiddle" alt="' + escapeFipiAttr(hint) + '"');
    }

    function ShowPictureT(s, hint) {
      writeImage(fipiRootUrl(s), 'align="absmiddle" alt="' + escapeFipiAttr(hint) + '"');
    }

    function ShowPicture(s, hint) {
      writeImage(fipiRootUrl(s), 'align="absmiddle" alt="' + escapeFipiAttr(hint) + '"');
    }

    function ShowPictureQ2(s, hint) {
      ShowPictureQ(s, hint);
    }

    function ShowPictureT2(s, hint) {
      ShowPictureT(s, hint);
    }

    function ShowXGraphic(s, hint) {
      writeImage(fipiRootUrl(s), 'align="absmiddle" alt="' + escapeFipiAttr(hint) + '"');
    }
  </script>
  <style>
    html, body { width: 100%; max-width: 100%; overflow-x: hidden; background: #0b0f14; color: #e6edf3; margin: 0; padding: 0; font-family: system-ui, sans-serif; font-size: 16px; }
    body { padding: 10px; }
    * { box-sizing: border-box; }
    .qblock { width: 100% !important; max-width: 100% !important; min-width: 0 !important; margin: 0 !important; padding: 0 !important; border: 0 !important; overflow-x: hidden !important; background: #0b0f14 !important; color: #e6edf3 !important; }
    .qblock > table, .cell_0 { width: 100% !important; max-width: 100% !important; }
    .qblock table { max-width: 100% !important; }
    .task-info, .task-info-content { background: #111820 !important; color: #e6edf3 !important; border-color: #263241 !important; }
    div, p, span, label, td, th, li, b, strong, font { color: #e6edf3 !important; }
    form, fieldset, .answer, .qanswer, .answer_area, .solution, .check-answer, .test-answer { background: transparent !important; border-color: #263241 !important; box-shadow: none !important; outline: 0 !important; }
    fieldset { border: 0 !important; padding: 0 !important; margin: 0 !important; }
    input, select, textarea { max-width: 100% !important; min-width: 0 !important; background: #0f1620 !important; background-color: #0f1620 !important; color: #e6edf3 !important; border: 1px solid #263241 !important; border-radius: 6px; padding: 8px; box-shadow: none !important; outline: none !important; }
    input[type="text"]:focus, textarea:focus, select:focus { border-color: #7db7ff !important; box-shadow: 0 0 0 1px #7db7ff !important; }
    input[type=radio], input[type=checkbox] { width: auto !important; max-width: none !important; padding: 0 !important; accent-color: #7db7ff; }
    button, input[type=button], input[type=submit] { background: #7db7ff !important; color: #07111d !important; border: 1px solid #7db7ff !important; border-radius: 6px; padding: 8px 10px; box-shadow: none !important; }
    table { border-collapse: collapse; width: 100% !important; table-layout: auto; background: #111820 !important; color: #e6edf3 !important; border-color: #263241 !important; }
    td, th { min-width: 0 !important; border-color: #263241 !important; padding: 6px; overflow-wrap: normal; word-break: normal; }
    p, div, th, .qblock td:not(.fipi-answer-cell):not(.fipi-choice-marker-cell):not(.fipi-choice-control-cell) { overflow-wrap: anywhere; }
    .fipi-answer-cell { white-space: normal !important; max-width: 100% !important; }
    .fipi-answer-inline { display: grid; grid-template-columns: minmax(0, 1fr) auto; gap: 8px; align-items: center; width: 100%; max-width: 100%; }
    .fipi-answer-inline input[type="text"], .fipi-answer-inline textarea, .fipi-answer-inline select { width: 100% !important; min-width: 0 !important; }
    .fipi-answer-unit { white-space: nowrap; }
    .fipi-option-marker, .fipi-choice-marker-cell { white-space: nowrap !important; word-break: keep-all !important; overflow-wrap: normal !important; hyphens: none !important; }
    .fipi-option-marker { display: inline-block !important; min-width: 1.6em !important; }
    .fipi-choice-marker-cell { width: 2.2em !important; min-width: 2.2em !important; max-width: 2.2em !important; text-align: center !important; vertical-align: top !important; padding-left: 4px !important; padding-right: 4px !important; }
    .fipi-choice-marker-cell br, .fipi-option-marker br { display: none !important; }
    .fipi-choice-control-cell { width: 2.4em !important; min-width: 2.4em !important; max-width: 2.4em !important; vertical-align: top !important; }
    .fipi-choice-text-cell { width: auto !important; max-width: 100% !important; white-space: normal !important; overflow-wrap: anywhere !important; word-break: normal !important; }
    a { color: #7db7ff !important; }
    img { max-width: 100% !important; height: auto !important; background: #ffffff !important; background-color: #ffffff !important; }
    svg, canvas { max-width: 100% !important; height: auto !important; }
    mjx-container { max-width: 100% !important; overflow-x: auto; overflow-y: hidden; }
    table[bgcolor], tr[bgcolor], td[bgcolor] { background: #111820 !important; background-color: #111820 !important; }
    tr[bgcolor="#FFFFFF"], tr[bgcolor="#ffffff"], td[bgcolor="#FFFFFF"], td[bgcolor="#ffffff"] { background: #111820 !important; background-color: #111820 !important; }
    table[bgcolor="gray"], table[bgcolor="grey"] { background: #111820 !important; background-color: #111820 !important; }
    .varinats-block, .variants-block, .answer-panel, .answer-table, .checkform, form[name^="checkform"], form[id^="checkform"] { background: transparent !important; background-color: transparent !important; border: 0 !important; box-shadow: none !important; outline: 0 !important; }
    .varinats-block table, .variants-block table, .answer-table { background: transparent !important; background-color: transparent !important; border: 0 !important; }
    .varinats-block td, .variants-block td, .answer-table td { background: transparent !important; background-color: transparent !important; border: 0 !important; }
    [style*="#FAFBCA"], [style*="#fafbca"], [style*="FAFBCA"], [bgcolor="#FAFBCA"], [bgcolor="#fafbca"] { background: #111820 !important; }
    [style*="background: white"], [style*="background-color: white"], [style*="background:#fff"], [style*="background-color:#fff"], [style*="background: rgb(255"], [style*="background-color: rgb(255"] { background: #111820 !important; }
    [style*="color: black"], [style*="color:#000"], [style*="color: rgb(0"] { color: #e6edf3 !important; }
  </style>
</head>
<body>
  $preparedHtml
  <script>
    (function () {
      function collectFields(form) {
        var data = {};
        var fields = form ? form.querySelectorAll('input, select, textarea') : document.querySelectorAll('input, select, textarea');
        function addField(name, value) {
          if (!data[name]) data[name] = [];
          data[name].push(value || '');
        }
        fields.forEach(function (field) {
          if (!field.name || field.disabled) return;
          if ((field.type === 'checkbox' || field.type === 'radio') && !field.checked) return;
          if (field.type === 'select-multiple' || field.multiple) {
            Array.prototype.slice.call(field.options || []).forEach(function (option) {
              if (option.selected) addField(field.name, option.value);
            });
            return;
          }
          addField(field.name, field.value);
        });
        return data;
      }
      function send(form) {
        if (!window.AnswerBridge || !window.AnswerBridge.postMessage) return;
        window.AnswerBridge.postMessage(JSON.stringify(collectFields(form)));
      }
      function formFor(target) {
        if (!target) return null;
        if (target.form) return target.form;
        if (target.closest) return target.closest('form');
        return null;
      }
      function scheduleSend(target) {
        setTimeout(function () {
          send(formFor(target));
        }, 80);
      }
      window.FipiSendAnswer = function () {
        document.querySelectorAll('input:checked, select, textarea, input[type="hidden"], input[type="text"]').forEach(function (field) {
          field.dispatchEvent(new Event('input', { bubbles: true }));
          field.dispatchEvent(new Event('change', { bubbles: true }));
        });
        setTimeout(function () {
          send(null);
        }, 120);
      };
      document.addEventListener('submit', function (event) {
        event.preventDefault();
        send(event.target);
      }, true);
      document.addEventListener('change', function (event) {
        scheduleSend(event.target);
      }, true);
      document.addEventListener('click', function (event) {
        var target = event.target;
        if (!target || !target.matches) return;
        if (!target.matches('input[type="checkbox"], input[type="radio"], select, option')) return;
        scheduleSend(target);
      }, true);
      window.FipiAnswerResult = function (status) {
        document.body.setAttribute('data-local-status', status);
      };
      function normalizeImages() {
        document.querySelectorAll('img').forEach(function (img) {
          var src = img.getAttribute('src');
          if (!src) return;
          img.setAttribute('src', normalizeFipiUrl(src));
          img.removeAttribute('width');
          img.style.maxWidth = '100%';
          img.style.height = 'auto';
          img.style.setProperty('background', '#fff', 'important');
          img.style.setProperty('background-color', '#fff', 'important');
        });
      }
      function reportImages() {
        if (!window.console) return;
        document.querySelectorAll('img').forEach(function (img) {
          console.log('[FIPI_IMG] src=' + img.src + ' complete=' + img.complete + ' natural=' + img.naturalWidth + 'x' + img.naturalHeight);
          img.addEventListener('error', function () {
            console.log('[FIPI_IMG_ERROR] ' + img.src);
          });
          img.addEventListener('load', function () {
            console.log('[FIPI_IMG_LOAD] ' + img.src + ' ' + img.naturalWidth + 'x' + img.naturalHeight);
          });
        });
      }
      function normalizeAnswerCells() {
        document.querySelectorAll('td').forEach(function (cell) {
          if (cell.classList.contains('fipi-answer-cell')) return;
          var field = cell.querySelector('input[type="text"], textarea, select');
          if (!field) return;
          cell.classList.add('fipi-answer-cell');
          var wrapper = document.createElement('span');
          wrapper.className = 'fipi-answer-inline';
          field.parentNode.insertBefore(wrapper, field);
          wrapper.appendChild(field);
          var unit = document.createElement('span');
          unit.className = 'fipi-answer-unit';
          var node = wrapper.nextSibling;
          while (node) {
            var next = node.nextSibling;
            var isInlineElement = node.nodeType === 1 && window.getComputedStyle(node).display.indexOf('inline') === 0;
            var isTextUnit = node.nodeType === 3 && node.nodeValue.trim() !== '';
            if (isTextUnit || isInlineElement) {
              unit.appendChild(node);
            } else if (node.nodeType === 3) {
              node.remove();
            } else {
              break;
            }
            node = next;
          }
          if (unit.childNodes.length) wrapper.appendChild(unit);
        });
      }
      function compactOptionMarkerText(value) {
        var compact = String(value || '').replace(/[ \\t\\r\\n]+/g, '');
        return /^[0-9]+[)]\$/.test(compact) ? compact : '';
      }
      function normalizeOptionMarkerElement(element) {
        if (!element) return false;
        if (element.querySelector && element.querySelector('input, select, textarea, img, svg, canvas, table')) {
          return false;
        }
        var marker = compactOptionMarkerText(element.textContent);
        if (!marker) return false;
        element.classList.add('fipi-option-marker');
        element.textContent = marker;
        return true;
      }
      function normalizeOptionNumbers() {
        document.querySelectorAll('input[type="checkbox"], input[type="radio"]').forEach(function (input) {
          var row = input.closest && input.closest('tr');
          if (!row) return;
          var cells = Array.prototype.slice.call(row.children || []).filter(function (cell) {
            var tag = (cell.tagName || '').toLowerCase();
            return tag === 'td' || tag === 'th';
          });
          if (!cells.length) return;
          var inputCellIndex = cells.findIndex(function (cell) {
            return cell.contains(input);
          });
          if (inputCellIndex < 0) return;
          var markerCell = null;
          for (var i = inputCellIndex + 1; i < cells.length; i += 1) {
            if (normalizeOptionMarkerElement(cells[i])) {
              markerCell = cells[i];
              break;
            }
          }
          if (!markerCell) return;
          row.classList.add('fipi-choice-row');
          cells[inputCellIndex].classList.add('fipi-choice-control-cell');
          markerCell.classList.add('fipi-choice-marker-cell');
          var markerIndex = cells.indexOf(markerCell);
          if (markerIndex >= 0 && markerIndex + 1 < cells.length) {
            cells[markerIndex + 1].classList.add('fipi-choice-text-cell');
          }
        });
        document.querySelectorAll('span, div, font, b, strong').forEach(function (element) {
          normalizeOptionMarkerElement(element);
        });
        var walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT);
        var nodes = [];
        while (walker.nextNode()) nodes.push(walker.currentNode);
        nodes.forEach(function (node) {
          if (!node.parentNode || node.parentNode.closest && node.parentNode.closest('.fipi-option-marker')) return;
          if (!/[0-9][ \\t\\r\\n]*[)]/.test(node.nodeValue)) return;
          var fragment = document.createDocumentFragment();
          var parts = node.nodeValue.split(/([0-9]+[ \\t\\r\\n]*[)])/g);
          parts.forEach(function (part) {
            if (!part) return;
            if (/^[0-9]+[ \\t\\r\\n]*[)]\$/.test(part)) {
              var span = document.createElement('span');
              span.className = 'fipi-option-marker';
              span.textContent = part.replace(/[ \\t\\r\\n]+/g, '');
              fragment.appendChild(span);
            } else {
              fragment.appendChild(document.createTextNode(part));
            }
          });
          node.parentNode.replaceChild(fragment, node);
        });
        document.querySelectorAll('span, div, font, b, strong').forEach(function (node) {
          if (node.childNodes.length !== 1) return;
          var text = node.textContent || '';
          if (!/^[ \\t\\r\\n]*[0-9]+[ \\t\\r\\n]*\$/.test(text)) return;
          var next = node.nextSibling;
          while (next && next.nodeType === 3 && next.nodeValue.trim() === '') next = next.nextSibling;
          if (!next || next.nodeType !== 3 || !/^[ \\t\\r\\n]*[)]/.test(next.nodeValue)) return;
          node.classList.add('fipi-option-marker');
          next.nodeValue = next.nodeValue.replace(/^[ \\t\\r\\n]*[)]/, ')');
        });
      }
      function normalizeMathMl() {
        var namespace = 'http://www.w3.org/1998/Math/MathML';
        function convert(node) {
          var tagName = node.tagName ? node.tagName.toLowerCase() : '';
          var isNamespacedMath = tagName.indexOf('m:') === 0;
          var replacement = isNamespacedMath
            ? document.createElementNS(namespace, tagName.substring(2))
            : node.cloneNode(false);
          Array.prototype.slice.call(node.attributes || []).forEach(function (attr) {
            if (attr.name.toLowerCase().indexOf('xmlns') === 0) return;
            replacement.setAttribute(attr.name, attr.value);
          });
          while (node.firstChild) {
            var child = node.firstChild;
            node.removeChild(child);
            replacement.appendChild(child.nodeType === 1 ? convert(child) : child);
          }
          if (isNamespacedMath && tagName === 'm:math') {
            replacement.setAttribute('xmlns', namespace);
          }
          return replacement;
        }
        var mathNodes = [];
        var walker = document.createTreeWalker(document.body, NodeFilter.SHOW_ELEMENT);
        while (walker.nextNode()) {
          var current = walker.currentNode;
          if (current.tagName && current.tagName.toLowerCase() === 'm:math') {
            mathNodes.push(current);
          }
        }
        mathNodes.forEach(function (math) {
          math.replaceWith(convert(math));
        });
      }
      function typesetMath() {
        if (window.MathJax && MathJax.startup && MathJax.startup.promise) {
          MathJax.startup.promise.then(function () {
            if (MathJax.typesetPromise) {
              MathJax.typesetPromise([document.body]).catch(function () {});
            }
          }).catch(function () {});
        } else if (window.MathJax && MathJax.typesetPromise) {
          MathJax.typesetPromise([document.body]).catch(function () {});
        }
        if (window.MathJax && MathJax.Hub && MathJax.Hub.Queue) {
          MathJax.Hub.Queue(['Typeset', MathJax.Hub, document.body]);
        }
      }
      normalizeImages();
      normalizeAnswerCells();
      normalizeOptionNumbers();
      normalizeMathMl();
      setTimeout(normalizeImages, 0);
      setTimeout(normalizeImages, 300);
      setTimeout(reportImages, 0);
      setTimeout(reportImages, 500);
      setTimeout(reportImages, 1500);
      setTimeout(normalizeAnswerCells, 0);
      setTimeout(normalizeAnswerCells, 300);
      setTimeout(normalizeOptionNumbers, 0);
      setTimeout(normalizeOptionNumbers, 300);
      setTimeout(normalizeOptionNumbers, 1000);
      setTimeout(normalizeMathMl, 0);
      setTimeout(normalizeMathMl, 300);
      setTimeout(typesetMath, 0);
      setTimeout(typesetMath, 500);
      setTimeout(typesetMath, 1200);
    })();
  </script>
</body>
</html>
''';
  }

  String resultScript(String status) =>
      'window.FipiAnswerResult && window.FipiAnswerResult(${jsonEncode(status)});';

  String _inlineFipiScriptPictures(String html) {
    return html.replaceAllMapped(
      RegExp(r'''<script\b[^>]*>([\s\S]*?)</script>''', caseSensitive: false),
      (match) {
        final script = match.group(1) ?? '';
        final images = _pictureCalls(script)
            .map(
              (call) =>
                  '<img src="${_escapeHtmlAttribute(_pictureUrl(call.functionName, call.path))}" align="absmiddle" alt="${_escapeHtmlAttribute(call.hint)}" style="${_escapeHtmlAttribute(_imageBackingStyle())}">',
            )
            .join();
        return images.isEmpty ? match.group(0)! : images;
      },
    );
  }

  Iterable<_FipiPictureCall> _pictureCalls(String script) sync* {
    final callPattern = RegExp(
      r'''(?:(?:window|parent|top)\.)?(ShowPictureQ2?|ShowPictureT2?|ShowPicture|ShowXGraphic)\s*\(\s*(['"])((?:\\.|(?!\2).)*?)\2''',
      caseSensitive: false,
    );
    for (final match in callPattern.allMatches(script)) {
      yield _FipiPictureCall(
        functionName: match.group(1) ?? '',
        path: _decodeJsString(match.group(3) ?? ''),
        hint: _decodeJsString(
          _secondStringArgument(script.substring(match.end)),
        ),
      );
    }
  }

  String _normalizeImageTags(String html) {
    return html.replaceAllMapped(RegExp(r'''<img\b([^>]*)>''', caseSensitive: false), (
      match,
    ) {
      final attributes = match.group(1) ?? '';
      final parsed = _parseAttributes(attributes);
      final source = parsed['src'];
      final sourceValue = source?.value;
      if (sourceValue == null || sourceValue.trim().isEmpty) {
        return match.group(0)!;
      }
      final parts = <String>[];
      var hasStyle = false;
      for (final entry in parsed.entries) {
        final name = entry.key;
        final attribute = entry.value;
        if (name == 'src') {
          parts.add(
            'src="${_escapeHtmlAttribute(_pictureUrl('ShowPictureQ', sourceValue))}"',
          );
        } else if (name == 'width' || name == 'height') {
          continue;
        } else if (name == 'style') {
          hasStyle = true;
          parts.add(
            'style="${_escapeHtmlAttribute(_responsiveImageStyle(attribute.value ?? ''))}"',
          );
        } else if (attribute.value == null) {
          parts.add(attribute.rawName);
        } else {
          parts.add(
            '${attribute.rawName}="${_escapeHtmlAttribute(attribute.value!)}"',
          );
        }
      }
      if (!hasStyle) {
        parts.add(
          'style="max-width:100%;height:auto;${_escapeHtmlAttribute(_imageBackingStyle())}"',
        );
      }
      return '<img ${parts.join(' ')}>';
    });
  }

  Map<String, _HtmlAttribute> _parseAttributes(String attributes) {
    final parsed = <String, _HtmlAttribute>{};
    final attributePattern = RegExp(
      r'''([^\s"'<>/=]+)(?:\s*=\s*(?:"([^"]*)"|'([^']*)'|([^\s"'=<>`]+)))?''',
    );
    for (final match in attributePattern.allMatches(attributes)) {
      final rawName = match.group(1) ?? '';
      if (rawName.isEmpty) continue;
      parsed[rawName.toLowerCase()] = _HtmlAttribute(
        rawName: rawName,
        value: match.group(2) ?? match.group(3) ?? match.group(4),
      );
    }
    return parsed;
  }

  String _pictureUrl(String functionName, String path) {
    final trimmed = path.trim();
    final lower = trimmed.toLowerCase();
    if (lower.startsWith('http://') || lower.startsWith('https://')) {
      return _httpsFipiUrl(trimmed);
    }
    if (trimmed.startsWith('/bank/')) {
      return _httpsFipiUrl('https://ege.fipi.ru$trimmed');
    }
    if (trimmed.startsWith('bank/')) {
      return _httpsFipiUrl('https://ege.fipi.ru/$trimmed');
    }
    if (trimmed.startsWith('/')) {
      return _httpsFipiUrl('https://ege.fipi.ru$trimmed');
    }
    if (trimmed.startsWith('../../')) {
      return _httpsFipiUrl(
        Uri.parse('https://ege.fipi.ru/bank/').resolve(trimmed).toString(),
      );
    }
    return _httpsFipiUrl('https://ege.fipi.ru/$trimmed');
  }

  String _httpsFipiUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || uri.host.isEmpty) return url;
    if (uri.host.endsWith('fipi.ru') && uri.scheme == 'http') {
      return uri.replace(scheme: 'https').toString();
    }
    return uri.toString();
  }

  String _decodeJsString(String value) {
    return value
        .replaceAll(r'\"', '"')
        .replaceAll(r"\'", "'")
        .replaceAll(r'\\', r'\');
  }

  String _secondStringArgument(String rest) {
    final match = RegExp(
      r'''\s*,\s*(['"])((?:\\.|(?!\1).)*?)\1''',
      caseSensitive: false,
    ).firstMatch(rest);
    return match?.group(2) ?? '';
  }

  String _responsiveImageStyle(String value) {
    final trimmed = value.trim();
    final separator = trimmed.isEmpty || trimmed.endsWith(';') ? '' : ';';
    return '$trimmed$separator max-width:100%;height:auto;${_imageBackingStyle()}';
  }

  String _imageBackingStyle() =>
      'background:#fff!important;background-color:#fff!important';

  String _escapeHtmlAttribute(String value) {
    return const HtmlEscape(HtmlEscapeMode.attribute).convert(value);
  }
}

class _HtmlAttribute {
  const _HtmlAttribute({required this.rawName, required this.value});

  final String rawName;
  final String? value;
}

class _FipiPictureCall {
  const _FipiPictureCall({
    required this.functionName,
    required this.path,
    required this.hint,
  });

  final String functionName;
  final String path;
  final String hint;
}
