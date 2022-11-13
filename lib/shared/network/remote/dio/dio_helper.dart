import 'package:dio/dio.dart';

abstract class DioHelper {
  Future<Response<T>> getMultiPart<T>(
    String url, {
    Map<String, dynamic>? queryParams,
  });

  Future<Response<T>> postMultiPart<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  });

  Future<Response<T>> delete<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  });

  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  });

  Future<dynamic> getFile(String? url);
}
