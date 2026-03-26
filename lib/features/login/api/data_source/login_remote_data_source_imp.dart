import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';

import 'package:online_exam_app_v/core/network/api_error_handler.dart';

import 'package:online_exam_app_v/features/login/api/login_api_client/login_api_client.dart';
import 'package:online_exam_app_v/features/login/data/datasources/login_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/data/models/user_model.dart';

@Injectable(as: LoginRemoteDataSourceContract)
class LoginRemoteDataSourceImp implements LoginRemoteDataSourceContract {
  LoginRemoteDataSourceImp(this.loginApiClient);
  final LoginApiClient loginApiClient;
  @override
  Future<BaseResponse<UserModel>> login(LoginRequest loginRequest) async {
    try {
      final response = await loginApiClient.login(loginRequest);

      return SuccessBaseResponse<UserModel>(data: response.user);
      // if (response is SuccessBaseResponse<UserModel>) {
      // } else {
      //   return ErrorBaseResponse<UserModel>(
      //     errorMessage: 'Registration failed: No user data received',
      //   );
      // }
    } catch (e) {
      return ErrorBaseResponse<UserModel>(errorMessage: ApiErrorHandler.getErrorMessage(e));
    }
  }
}
