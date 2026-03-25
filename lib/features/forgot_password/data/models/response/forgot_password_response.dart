import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/entities/forget_password_entity.dart'
    show ForgotPasswordEntity;

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  final String? message;
  final String? info;
  final String? statusMsg;

  const ForgotPasswordResponse({this.message, this.info, this.statusMsg});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

  ForgotPasswordEntity toEntity() =>
      ForgotPasswordEntity(message: message, info: info, statusMsg: statusMsg);
}
