import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app_interceptors.dart';

class DioClient {
  late final Dio _dio;
  DioClient() {
    const timeout = Duration(seconds: 20);
    BaseOptions options = BaseOptions(
      baseUrl:
          dotenv.env['BASE_API_URL'] ??
          'https://admin.globaltakeout.com/api/v1',
      connectTimeout: timeout,
      receiveTimeout: timeout,
      sendTimeout: timeout,
      contentType: Headers.jsonContentType,
    );
    _dio = Dio(options);
    _dio.interceptors.add(AppInterceptors());
  }
  Dio get client => _dio;
}
