import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_responce.dart';
import 'package:online_exam_app_v/feature/login/data/models/login_request.dart';
import 'package:online_exam_app_v/feature/login/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/feature/login/domain/repositories/login_repo_contract.dart';


@lazySingleton
class LoginUseCase {
  LoginUseCase(this.loginRepoContract);
  LoginRepoContract loginRepoContract;
  Future<BaseResponse<UserEntity>> call(LoginRequest loginRequest) async {
    return  await loginRepoContract.login(loginRequest);
  }
}
