import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/forgot_password_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/reset_password_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/request/verify_reset_code_request.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/forgot_password_response.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/reset_password_response.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/verify_reset_code_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:online_exam_app_v/core/constants/app_endpoints.dart';

part 'forgot_password_api_client.g.dart';

@injectable
@RestApi(baseUrl: AppEndpoints.baseUrl)
abstract class ForgotPasswordApiClient {
  @factoryMethod
  factory ForgotPasswordApiClient(Dio dio) = _ForgotPasswordApiClient;

  @POST(AppEndpoints.forgotPassword)
  Future<ForgotPasswordResponse> forgotPassword(
    @Body() ForgotPasswordRequest request,
  );

  @POST(AppEndpoints.verifyResetCode)
  Future<VerifyResetCodeResponse> verifyResetCode(
    @Body() VerifyResetCodeRequest request,
  );

  @PUT(AppEndpoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequest request,
  );
}
