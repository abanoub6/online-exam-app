<<<<<<<< HEAD:lib/features/login/data/data_sources/login_remote_data_source_contract.dart
========

>>>>>>>> 22589478c27956ed8f971823d66ac2b102068ab3:lib/features/login/data/datasources/login_remote_data_source_contract.dart
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/data/models/user_model.dart';

abstract class LoginRemoteDataSourceContract {
  Future<BaseResponse<UserModel>> login(LoginRequest loginRequest);
}
