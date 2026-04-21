import 'package:online_exam_app_v/features/profile/domain/entities/profile_entity.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileLoading extends ProfileState {}

class GetProfileSuccess extends ProfileState {
  final ProfileEntity profile;
  GetProfileSuccess(this.profile);
}

class GetProfileFailure extends ProfileState {
  final String errorMessage;
  GetProfileFailure(this.errorMessage);
}

class EditProfileLoading extends ProfileState {}

class EditProfileSuccess extends ProfileState {
  final ProfileEntity profile;
  EditProfileSuccess(this.profile);
}

class EditProfileFailure extends ProfileState {
  final String errorMessage;
  EditProfileFailure(this.errorMessage);
}

class ChangePasswordLoading extends ProfileState {}

class ChangePasswordSuccess extends ProfileState {}

class ChangePasswordFailure extends ProfileState {
  final String errorMessage;
  ChangePasswordFailure(this.errorMessage);
}
