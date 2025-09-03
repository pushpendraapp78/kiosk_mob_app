// import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:ipbot_app/repo/setting_repo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'global_configuration.dart';

BaseOptions options = BaseOptions(
  baseUrl: getURL(),
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
  maxRedirects: 2,
  responseType: ResponseType.json,
  contentType: "application/json",
  validateStatus: (status) {
    return status! <= 500;
  },
);

var _apiDio = Dio(options);

bool isLoading = false;

Dio httpClient() {
  _apiDio.interceptors.add(LogInterceptor(
    requestHeader: !kReleaseMode,
    requestBody: !kReleaseMode,
    responseBody: !kReleaseMode,
  ));
  _apiDio.interceptors.add(HeaderInterceptor());
  (_apiDio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  return _apiDio;
}

Dio httpClientWithHeader() {
  _apiDio.options.headers
      .addAll({"Authorization": 'Bearer ${auth.value.token}'});
  _apiDio.interceptors.add(PrettyDioLogger(
    requestHeader: !kReleaseMode,
    requestBody: !kReleaseMode,
    responseBody: !kReleaseMode,
  ));

  (_apiDio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  return _apiDio;
}

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _apiDio.interceptors.clear();
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _apiDio.interceptors.clear();

    return super.onError(err, handler);
  }
}

String getURL() {
  final url = GlobalConfiguration().getValue('api_url')?.toString();
  print('API URL: $url'); // Debug log
  if (url == null) {
    throw Exception('api_url not found in configuration');
  }
  return url;
}
