import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'dio_helper.dart';
import 'interceptors/app_interceptor.dart';

typedef RequestCallback = Future<Map<String, dynamic>> Function();
typedef ResponseCallback = Future<void> Function(Response);
typedef ErrorCallback = Future<void> Function(DioError);

class DioImpl extends DioHelper {
  final RequestCallback? onRequest;
  final ResponseCallback? onResponse;
  final ErrorCallback? onError;

  final String baseURL;
  late Dio _client;
  DioImpl({
    required this.baseURL,
    this.onResponse,
    this.onRequest,
    this.onError,
  }) {
    _client = Dio()
      ..interceptors.addAll([
        if (kDebugMode)
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            error: true,
          ),
        AppInterceptors(
          onRequest,
          onResponse,
          onError,
        ),
      ])
      ..options.baseUrl = baseURL
      ..options.headers.addAll({'Accept': 'application/json'});
  }

  @override
  Future<Response<T>> getMultiPart<T>(
    String url, {
    Map<String, dynamic>? queryParams,
  }) {
    return _client.get(
      url,
      queryParameters: queryParams,
    );
  }

  @override
  Future<Response<T>> postMultiPart<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) {
    return _client.post(
      url,
      data: data,
      queryParameters: queryParams,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) {
    return _client.put(
      url,
      data: data,
      queryParameters: queryParams,
    );
  }

  @override
  Future<Response<T>> delete<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) {
    return _client.delete(
      url,
      data: data,
      queryParameters: queryParams,
    );
  }

  @override
  Future getFile(String? url) async {
    return _client.get(
      url!,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
  }
}
