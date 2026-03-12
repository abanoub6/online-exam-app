import 'package:online_exam_app_v/features/register/data/models/register_request.dart';

sealed class RegisterEvents {}

class RegisterUserEvent extends RegisterEvents {
  final RegisterRequest request;

  RegisterUserEvent(this.request);
}

class ClearRegisterErrorEvent extends RegisterEvents {}
