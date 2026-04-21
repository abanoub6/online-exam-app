import 'package:equatable/equatable.dart';

class ChangePasswordResponse extends Equatable {
  final String message;
  final String token;

  const ChangePasswordResponse({required this.message, required this.token});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
        message: json['message'] ?? '',
        token: json['token'] ?? '',
      );

  @override
  List<Object?> get props => [message, token];
}
