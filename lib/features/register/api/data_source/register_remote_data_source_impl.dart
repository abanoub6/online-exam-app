import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_responce.dart';
import 'package:online_exam_app_v/features/register/api/home_api_client/register_api_client.dart';
import 'package:online_exam_app_v/features/register/data/data_sources/register_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/register/data/models/register_request.dart';
import 'package:online_exam_app_v/features/register/data/models/user_dto.dart';

@Injectable(as: RegisterRemoteDataSourceContract)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSourceContract {
  final RegisterApiClient registerApiClient;

  RegisterRemoteDataSourceImpl(this.registerApiClient);

  @override
  Future<BaseResponse<UserDto>> register(
    RegisterRequest registerRequest,
  ) async {
    try {
      // API call
      final response = await registerApiClient.register(registerRequest);

      // Debug print full response
      print("[DEBUG] Register Response: $response");

      // Success if user data exists
      if (response.user != null) {
        return SuccessBaseResponse<UserDto>(data: response.user!);
      } else {
        return ErrorBaseResponse<UserDto>(
          errorMessage: 'Registration failed: No user data received',
        );
      }
    } on DioException catch (dioError) {
      // Debug print for DioError
      print("[DEBUG] DioException: ${dioError.message}");
      print("[DEBUG] DioException Response: ${dioError.response?.data}");

      String errorMessage;

      // Backend sent error message
      if (dioError.response?.data != null &&
          dioError.response?.data['message'] != null) {
        errorMessage = dioError.response!.data['message'];
      } else if (dioError.type == DioExceptionType.connectionTimeout ||
          dioError.type == DioExceptionType.sendTimeout ||
          dioError.type == DioExceptionType.receiveTimeout) {
        errorMessage =
            'Request timed out. Please check your connection and try again';
      } else if (dioError.type == DioExceptionType.badResponse) {
        errorMessage = 'Server error occurred. Please try again later';
      } else {
        errorMessage =
            'Connection error. Please check your internet connection';
      }

      return ErrorBaseResponse<UserDto>(errorMessage: errorMessage);
    } on TimeoutException catch (e) {
      print("[DEBUG] TimeoutException: $e");
      return ErrorBaseResponse<UserDto>(
        errorMessage: 'Request timed out. Please try again',
      );
    } catch (e) {
      print("[DEBUG] Unexpected Exception: $e");
      return ErrorBaseResponse<UserDto>(
        errorMessage: 'An unexpected error occurred. Please try again',
      );
    }
  }
}
