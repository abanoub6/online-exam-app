import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/core/network/api_error_handler.dart';
import 'package:online_exam_app_v/features/forgot_password/data/data_source/forgot_password_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/forgot_password_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/reset_password_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/verify_reset_code_request.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/entities/forget_password_entity.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/repo/forget_password_repo_contract.dart';

@Injectable(as: ForgetPasswordRepoContract)
class ForgetPasswordRepoImpl implements ForgetPasswordRepoContract {
  final ForgotPasswordRemoteDataSourceContract _remoteDataSource;

  ForgetPasswordRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<ForgotPasswordEntity>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await _remoteDataSource.forgotPassword(
        ForgotPasswordRequest(email: email),
      );
      return SuccessBaseResponse(data: response.toEntity());
    } on DioException catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<BaseResponse<ForgotPasswordEntity>> verifyResetCode({
    required String resetCode,
  }) async {
    try {
      final response = await _remoteDataSource.verifyResetCode(
        VerifyResetCodeRequest(resetCode: resetCode),
      );
      return SuccessBaseResponse(data: response.toEntity());
    } on DioException catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<BaseResponse<ForgotPasswordEntity>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await _remoteDataSource.resetPassword(
        ResetPasswordRequest(email: email, newPassword: newPassword),
      );
      return SuccessBaseResponse(data: response.toEntity());
    } on DioException catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    }
  }
}
