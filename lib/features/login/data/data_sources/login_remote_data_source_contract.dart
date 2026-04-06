import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/data/models/user_model.dart';

abstract class LoginRemoteDataSourceContract {
  Future<UserModel> login(LoginRequest loginRequest);
}
