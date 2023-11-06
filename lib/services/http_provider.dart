import 'package:dio/dio.dart';

class HttpProvider {
  final Dio _dio;

  HttpProvider({
    List<Interceptor>? interceptors,
  }) : _dio = Dio(BaseOptions(
          baseUrl: 'https://brapi.dev/api/v2/crypto',
          contentType: 'application/json; charset=utf-8',
        )) {
    _dio.interceptors.add(LogInterceptor());
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    return _dio.get(endpoint, queryParameters: queryParameters);
  }

  Future<Response> post(String endpoint, {Object? data}) {
    return _dio.post(endpoint, data: data);
  }

  Future<Response> put(String endpoint, {Map<String, dynamic>? data}) {
    return _dio.put(endpoint, data: data);
  }

  Future<Response> delete(String endpoint, {Map<String, dynamic>? data}) {
    return _dio.delete(endpoint, data: data);
  }
}