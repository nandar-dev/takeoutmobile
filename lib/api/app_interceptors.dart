import 'dart:io';
import 'package:dio/dio.dart';
import 'package:takeout/utils/token_service.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenStorage.getToken();
    // final token = 'token123';

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    print('➡️ ${options.method} ${options.uri}');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ ${response.statusCode} ${response.requestOptions.uri}');
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ${err.response?.statusCode} ${err.message}');

    String errorMessage = 'An unexpected error occurred.';

    if (err.response?.statusCode != null) {
      switch (err.response!.statusCode) {
        case 400:
          errorMessage = 'Bad Request: The request was invalid.';
          break;
        case 401:
          errorMessage = 'Unauthorized: Authentication is required.';
          break;
        case 403:
          errorMessage =
              'Forbidden: You do not have permission to access this resource.';
          break;
        case 404:
          errorMessage = 'Not Found: The requested resource was not found.';
          break;
        case 408:
          errorMessage = 'Request Timeout: The server did not respond in time.';
          break;
        case 500:
          errorMessage =
              'Internal Server Error: Something went wrong on the server.';
          break;
        case 502:
          errorMessage =
              'Bad Gateway: The server received an invalid response from an upstream server.';
          break;
        case 503:
          errorMessage =
              'Service Unavailable: The server is currently unable to handle the request.';
          break;
        default:
          errorMessage =
              'Error: Request failed with status code ${err.response!.statusCode}.';
      }
    } else if (err.type == DioExceptionType.connectionTimeout) {
      errorMessage = 'Connection Timeout: Could not connect to the server.';
    } else if (err.type == DioExceptionType.receiveTimeout) {
      errorMessage =
          'Receive Timeout: Did not receive a response from the server in time.';
    } else if (err.type == DioExceptionType.sendTimeout) {
      errorMessage =
          'Send Timeout: Failed to send the request to the server in time.';
    } else if (err.type == DioExceptionType.cancel) {
      errorMessage =
          'Request Cancelled: The request was intentionally cancelled.';
    } else if (err.type == DioExceptionType.badResponse) {
      errorMessage =
          'Bad Response: The server returned an invalid response format.';
    } else if (err.type == DioExceptionType.unknown &&
        err.error is SocketException) {
      errorMessage = 'Network Error: Please check your internet connection.';
    }

    print('❗️ Error Message: $errorMessage');

    final customError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      error: errorMessage,
      type: err.type,
    );

    return handler.next(customError);
  }
}
