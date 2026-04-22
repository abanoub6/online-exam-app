import 'package:online_exam_app_v/features/forgot_password/data/models/request/forgot_password_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/reset_password_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/verify_reset_code_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/forgot_password_response.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/reset_password_response.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/verify_reset_code_response.dart';

abstract interface class ForgotPasswordRemoteDataSourceContract {
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request);
  Future<VerifyResetCodeResponse> verifyResetCode(
    VerifyResetCodeRequest request,
  );
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request);
}
