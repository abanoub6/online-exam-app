import 'package:dio/dio.dart';

sealed class BaseResponse<T> {}

class SuccessBaseResponse<T> extends BaseResponse<T> {
  T data;
  SuccessBaseResponse({required this.data});
}

class ErrorBaseResponse<T> extends BaseResponse<T> {
  final String errorMessage;

  ErrorBaseResponse({required this.errorMessage});

  factory ErrorBaseResponse.fromException(dynamic error) {
    if (error is DioException) {
      if (error.response?.data != null &&
          error.response?.data['message'] != null) {
        return ErrorBaseResponse(errorMessage: error.response!.data['message']);
      }

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return ErrorBaseResponse(
          errorMessage:
              'Request timed out. Please check your connection and try again',
        );
      }

      if (error.type == DioExceptionType.badResponse) {
        return ErrorBaseResponse(
          errorMessage: 'Server error occurred. Please try again later',
        );
      }

      return ErrorBaseResponse(
        errorMessage: 'Connection error. Please check your internet connection',
      );
    }

    return ErrorBaseResponse(
      errorMessage: 'An unexpected error occurred. Please try again',
    );
  }
}