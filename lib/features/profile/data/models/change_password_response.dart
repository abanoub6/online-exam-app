import 'package:equatable/equatable.dart';

class ChangePasswordResponse extends Equatable {
  final String? message;
  final String? token;

  const ChangePasswordResponse({this.message, this.token});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
        message: json['message'] as String?,
        token: json['token'] as String?,
      );

  @override
  List<Object?> get props => [message, token];
}
