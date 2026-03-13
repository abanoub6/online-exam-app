import 'package:online_exam_app_v/core/constants/app_api_param.dart';

class RegisterRequest {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  RegisterRequest({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
    AppApiParam.username: username,
    AppApiParam.firstName: firstName,
    AppApiParam.lastName: lastName,
    AppApiParam.email: email,
    AppApiParam.password: password,
    AppApiParam.rePassword: rePassword,
    AppApiParam.phone: phone,
  };
}
