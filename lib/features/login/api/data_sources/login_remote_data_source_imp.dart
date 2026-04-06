import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/login/api/login_api_client/login_api_client.dart';
import 'package:online_exam_app_v/features/login/data/data_sources/login_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/data/models/user_model.dart';

@Injectable(as: LoginRemoteDataSourceContract)
class LoginRemoteDataSourceImp implements LoginRemoteDataSourceContract {
  final LoginApiClient loginApiClient;

  LoginRemoteDataSourceImp(this.loginApiClient);

  @override
  Future<UserModel> login(LoginRequest loginRequest) async {
    final response = await loginApiClient.login(loginRequest);
    return response.user;
  }
}