import 'package:dio/dio.dart';
import 'dio_client.dart';

enum DioMethod { get, post, put, delete }

class APIService {
  static final Dio _dio = DioClient().client;

  static Future<Response> request(
    String endpoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    dynamic data,
    String? contentType,
  }) async {
    try {
      switch (method) {
        case DioMethod.get:
          return _dio.get(endpoint, queryParameters: param);
        case DioMethod.post:
          return _dio.post(endpoint, data: data ?? param);
        case DioMethod.put:
          return _dio.put(endpoint, data: data ?? param);
        case DioMethod.delete:
          return _dio.delete(endpoint, data: data ?? param);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
