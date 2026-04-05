import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/data/models/user_model.dart';

abstract class LoginRemoteDataSourceContract {
  Future<BaseResponse<UserModel>> login(LoginRequest loginRequest);
}
