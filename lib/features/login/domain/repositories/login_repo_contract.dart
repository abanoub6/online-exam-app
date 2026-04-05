<<<<<<<< HEAD:lib/features/login/domain/repo/login_repo_contract.dart
========

>>>>>>>> 22589478c27956ed8f971823d66ac2b102068ab3:lib/features/login/domain/repositories/login_repo_contract.dart
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/domain/entities/user_entity.dart';

abstract class LoginRepoContract {
  Future<BaseResponse<UserEntity>> login(LoginRequest loginRequest);

  void rememberMe(bool rememberMe);

  Future<bool?> isRememberedMe();
}
