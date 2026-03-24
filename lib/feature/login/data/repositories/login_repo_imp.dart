import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_responce.dart';
import 'package:online_exam_app_v/feature/login/data/datasources/login_remote_data_source_contract.dart';
import 'package:online_exam_app_v/feature/login/data/models/login_request.dart';
import 'package:online_exam_app_v/feature/login/data/models/login_response_model.dart';
import 'package:online_exam_app_v/feature/login/data/models/user_model.dart';
import 'package:online_exam_app_v/feature/login/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/feature/login/domain/repositories/login_repo_contract.dart';

@Injectable(as: LoginRepoContract)
class LoginRepoImp implements LoginRepoContract {
  LoginRepoImp(this.loginRemoteDataSourceContract);
  LoginRemoteDataSourceContract loginRemoteDataSourceContract;
  @override
  Future<BaseResponse<UserEntity>> login(LoginRequest loginRequest) async {
    BaseResponse<UserModel> response = await loginRemoteDataSourceContract
        .login(loginRequest);
    switch (response) {
      case SuccessBaseResponse<UserModel>():
        return SuccessBaseResponse<UserEntity>(data: response.data.toEntity());
      case ErrorBaseResponse<UserModel>():
        return ErrorBaseResponse<UserEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
