import 'package:equatable/equatable.dart';
import 'user_model.dart';

class LoginResponseModel extends Equatable {
  final String message;
  final String token;
  final UserModel user;

  const LoginResponseModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json['message'] ?? '',
        token: json['token'] ?? '',
        user: UserModel.fromJson(json['user']),
      );

  @override
  List<Object?> get props => [message, token, user];
}
