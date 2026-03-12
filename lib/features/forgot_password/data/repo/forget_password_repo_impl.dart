import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/forgot_password/data/api/api_service.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/forgot_password_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/reset_password_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/verify_reset_code_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/forgot_password_response.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/reset_password_response.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/verify_reset_code_response.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/repo/forget_password_repo_contract.dart';
import '../../../../core/errors/failures.dart';

@LazySingleton(as: ForgetPasswordRepoContract)
class ForgetPasswordRepoImpl implements ForgetPasswordRepoContract {
  final AuthApiService _apiService;

  ForgetPasswordRepoImpl(this._apiService);

  @override
  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await _apiService.forgotPassword(
        ForgotPasswordRequest(email: email),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerifyResetCodeResponse>> verifyResetCode({
    required String resetCode,
  }) async {
    try {
      final response = await _apiService.verifyResetCode(
        VerifyResetCodeRequest(resetCode: resetCode),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResponse>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await _apiService.resetPassword(
        ResetPasswordRequest(email: email, newPassword: newPassword),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
