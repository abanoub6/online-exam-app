import 'package:dio/dio.dart';
import 'app_error_strings.dart';

class ApiErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      // لو السيرفر رجّع message
      if (error.response?.data != null &&
          error.response?.data is Map &&
          error.response?.data['message'] != null) {
        return error.response!.data['message'];
      }

      // Timeout
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return AppErrorStrings.timeoutError;
      }

      // Server error (500 - 400)
      if (error.type == DioExceptionType.badResponse) {
        return AppErrorStrings.serverError;
      }

      // Network error
      return AppErrorStrings.connectionError;
    }

    // Unknown error
    return AppErrorStrings.unexpectedError;
  }
}
