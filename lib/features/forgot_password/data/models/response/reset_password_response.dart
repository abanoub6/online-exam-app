import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/entities/forget_password_entity.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  final String? message;
  final String? token;

  const ResetPasswordResponse({this.message, this.token});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);

  ForgotPasswordEntity toEntity() =>
      ForgotPasswordEntity(message: message, token: token);
}
