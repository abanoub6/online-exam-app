import 'package:online_exam_app_v/core/constants/app_api_param.dart';

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
    AppApiParam.email: email,
    AppApiParam.password: password,
  };
}
