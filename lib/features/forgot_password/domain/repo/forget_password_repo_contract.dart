import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/entities/forget_password_entity.dart';

abstract interface class ForgetPasswordRepoContract {
  Future<BaseResponse<ForgotPasswordEntity>> forgotPassword({
    required String email,
  });

  Future<BaseResponse<ForgotPasswordEntity>> verifyResetCode({
    required String resetCode,
  });

  Future<BaseResponse<ForgotPasswordEntity>> resetPassword({
    required String email,
    required String newPassword,
  });
}
