import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/forgot_password/data/api/api_service.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/forgot_password_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/reset_password_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/verify_reset_code_request.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/entities/forget_password_entity.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/repo/forget_password_repo_contract.dart';
import '../../../../core/errors/failures.dart';

@LazySingleton(as: ForgetPasswordRepoContract)
class ForgetPasswordRepoImpl implements ForgetPasswordRepoContract {
  final AuthApiService _apiService;

  ForgetPasswordRepoImpl(this._apiService);

  @override
  Future<BaseResponse<ForgotPasswordEntity>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await _apiService.forgotPassword(
        ForgotPasswordRequest(email: email),
      );
      return SuccessBaseResponse(data: response.toEntity());
    } on DioException catch (e) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.fromDioException(e).message,
      );
    } catch (e) {
      return ErrorBaseResponse.fromException(e);
    }
  }

  @override
  Future<BaseResponse<ForgotPasswordEntity>> verifyResetCode({
    required String resetCode,
  }) async {
    try {
      final response = await _apiService.verifyResetCode(
        VerifyResetCodeRequest(resetCode: resetCode),
      );
      return SuccessBaseResponse(data: response.toEntity());
    } on DioException catch (e) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.fromDioException(e).message,
      );
    } catch (e) {
      return ErrorBaseResponse.fromException(e);
    }
  }

  @override
  Future<BaseResponse<ForgotPasswordEntity>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await _apiService.resetPassword(
        ResetPasswordRequest(email: email, newPassword: newPassword),
      );
      return SuccessBaseResponse(data: response.toEntity());
    } on DioException catch (e) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.fromDioException(e).message,
      );
    } catch (e) {
      return ErrorBaseResponse.fromException(e);
    }
  }
}
