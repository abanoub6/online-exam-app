import 'package:online_exam_app_v/features/login/data/models/login_request.dart';

sealed class LoginEvents {}

class LoginUserEvent extends LoginEvents {
  final LoginRequest login;

  LoginUserEvent({required this.login});
}


// class ClearUserEvent extends LoginEvents {}
