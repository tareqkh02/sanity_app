import 'package:dio/dio.dart';
import 'package:safe_chat/core/constants/api_constants.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  void setAuthToken(String token) {
    _dio.options.headers[ApiConstants.authHeader] =
        '${ApiConstants.authHeaderPrefix}$token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove(ApiConstants.authHeader);
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get<T>(path, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
  }) async {
    return _dio.post<T>(path, data: data);
  }
}
