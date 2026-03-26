import 'package:online_exam_app_v/config/base_responce/base_responce.dart';
import 'package:online_exam_app_v/feature/login/data/models/login_request.dart';
import 'package:online_exam_app_v/feature/login/domain/entities/user_entity.dart';

abstract class LoginRepoContract {
  Future<BaseResponse<UserEntity>> login(LoginRequest loginRequest);

  
  void rememberMe(bool rememberMe);

  Future<bool?> isRememberedMe();
}
