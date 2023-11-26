import 'package:dio/dio.dart';

class Requester<T> {
  final Dio _dio;

  Dio get dio => _dio;

  const Requester(this._dio);

  void addToken(String token) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response<T>> get(String path, Map<String, String>? queryString) {
    return _dio.get<T>(path, queryParameters: queryString);
  }

  Future<Response<T>> post(String path, Map<String, dynamic>? body) {
    return _dio.post<T>(path, data: body);
  }
}
