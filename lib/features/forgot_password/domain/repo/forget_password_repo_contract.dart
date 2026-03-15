import 'package:dartz/dartz.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/forgot_password_response.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/reset_password_response.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/verify_reset_code_response.dart';
import '../../../../core/errors/failures.dart';

abstract class ForgetPasswordRepoContract {
  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword({
    required String email,
  });

  Future<Either<Failure, VerifyResetCodeResponse>> verifyResetCode({
    required String resetCode,
  });

  Future<Either<Failure, ResetPasswordResponse>> resetPassword({
    required String email,
    required String newPassword,
  });
}
