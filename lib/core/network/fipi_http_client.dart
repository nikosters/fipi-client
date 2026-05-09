import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:windows1251/windows1251.dart';

import 'fipi_endpoints.dart';

class FipiHttpClient {
  FipiHttpClient._(this._dio, this._jar);

  final Dio _dio;
  final PersistCookieJar _jar;

  static Future<FipiHttpClient> create() async {
    final dir = await getApplicationSupportDirectory();
    final jar = PersistCookieJar(storage: FileStorage('${dir.path}/cookies'));
    final securityContext = await _securityContext();
    final dio =
        Dio(
            BaseOptions(
              baseUrl: FipiEndpoints.baseUrl,
              responseType: ResponseType.bytes,
              headers: const {
                'User-Agent':
                    'Mozilla/5.0 (Linux; Android 14) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Mobile Safari/537.36',
                'Accept-Language': 'ru-RU,ru;q=0.9,en;q=0.8',
                'Accept':
                    'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
              },
            ),
          )
          ..httpClientAdapter = IOHttpClientAdapter(
            createHttpClient: () => HttpClient(context: securityContext),
          )
          ..interceptors.add(CookieManager(jar));
    return FipiHttpClient._(dio, jar);
  }

  static Future<SecurityContext> _securityContext() async {
    final context = SecurityContext(withTrustedRoots: true);
    final data = await rootBundle.load(
      'assets/certs/globalsign_gcc_r3_dv_tls_ca_2020.pem',
    );
    context.setTrustedCertificatesBytes(data.buffer.asUint8List());
    return context;
  }

  Future<String> getHtml(String path, Map<String, String> query) async {
    final response = await _dio.get<List<int>>(path, queryParameters: query);
    return _decode(response.data);
  }

  Future<String> postForm(String path, Map<String, String> fields) async {
    final response = await _dio.post<List<int>>(
      path,
      data: FormData.fromMap(fields),
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    return _decode(response.data);
  }

  Future<String> postMultipart(String path, Map<String, String> fields) async {
    final response = await _dio.post<List<int>>(
      path,
      data: FormData.fromMap(fields),
    );
    return _decode(response.data);
  }

  Future<FipiBinaryResponse> getBinaryUrl(String url) async {
    final response = await _dio.getUri<List<int>>(
      Uri.parse(url),
      options: Options(
        responseType: ResponseType.bytes,
        headers: const {
          'Accept':
              'image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8',
          'Referer': 'https://ege.fipi.ru/bank/',
        },
      ),
    );
    return FipiBinaryResponse(
      bytes: Uint8List.fromList(response.data ?? const []),
      contentType: response.headers.value(Headers.contentTypeHeader),
    );
  }

  Future<List<Cookie>> fipiCookies() async {
    final cookies = <String, Cookie>{};
    for (final uri in const [
      'https://ege.fipi.ru/',
      'https://ege.fipi.ru/bank/',
    ]) {
      for (final cookie in await _jar.loadForRequest(Uri.parse(uri))) {
        cookies[cookie.name] = cookie;
      }
    }
    return cookies.values.toList();
  }

  String _decode(List<int>? data) {
    final bytes = data == null ? Uint8List(0) : Uint8List.fromList(data);
    return windows1251.decode(bytes, allowInvalid: true);
  }
}

class FipiBinaryResponse {
  const FipiBinaryResponse({required this.bytes, required this.contentType});

  final Uint8List bytes;
  final String? contentType;
}
