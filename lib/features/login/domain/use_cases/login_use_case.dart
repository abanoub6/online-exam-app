import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/features/login/domain/repo/login_repo_contract.dart';

@lazySingleton
class LoginUseCase {
  LoginUseCase(this.loginRepoContract);
  LoginRepoContract loginRepoContract;

  Future<BaseResponse<UserEntity>> call(LoginRequest loginRequest) =>
      loginRepoContract.login(loginRequest);
}
