import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timed out. Please try again.');
      case DioExceptionType.sendTimeout:
        return const ServerFailure('Request timed out. Please try again.');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Server took too long to respond.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response?.statusCode ?? 500,
          e.response?.data,
        );
      case DioExceptionType.cancel:
        return const ServerFailure('Request was cancelled.');
      case DioExceptionType.connectionError:
        return const ServerFailure('No internet connection.');
      default:
        return const ServerFailure('Something went wrong. Please try again.');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic data) {
    final message = _extractMessage(data);

    switch (statusCode) {
      case 400:
        return ServerFailure(message ?? 'Bad request.');
      case 401:
        return ServerFailure(
          message ?? 'Unauthorized. Check your credentials.',
        );
      case 403:
        return ServerFailure(message ?? 'Access denied.');
      case 404:
        return ServerFailure(message ?? 'Resource not found.');
      case 409:
        return ServerFailure(
          message ?? 'Conflict. This resource already exists.',
        );
      case 422:
        return ServerFailure(message ?? 'Invalid data provided.');
      case 500:
        return ServerFailure(message ?? 'Internal server error.');
      default:
        return ServerFailure(message ?? 'Unexpected error occurred.');
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ??
          data['error'] as String? ??
          data['errors']?.toString();
    }
    if (data is String) return data;
    return null;
  }
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'No internet connection. Please check your network.',
  ]);
}
