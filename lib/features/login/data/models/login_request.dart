import 'package:online_exam_app_v/core/constants/app_api_param.dart';

class LoginRequest {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginRequest({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  Map<String, dynamic> toJson() => {
    AppApiParam.email: email,
    AppApiParam.password: password,
  };

  LoginRequest copyWith({bool? rememberMe}) {
    return LoginRequest(
      email: email,
      password: password,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
