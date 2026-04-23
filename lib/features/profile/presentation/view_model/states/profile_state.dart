import 'package:equatable/equatable.dart';
import 'package:online_exam_app_v/features/profile/domain/entities/profile_entity.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();

  @override
  List<Object?> get props => [];
}

class GetProfileLoading extends ProfileState {
  const GetProfileLoading();

  @override
  List<Object?> get props => [];
}

class GetProfileSuccess extends ProfileState {
  final ProfileEntity profile;
  const GetProfileSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

class GetProfileFailure extends ProfileState {
  final String errorMessage;
  const GetProfileFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class EditProfileLoading extends ProfileState {
  const EditProfileLoading();

  @override
  List<Object?> get props => [];
}

class EditProfileSuccess extends ProfileState {
  final ProfileEntity profile;
  const EditProfileSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

class EditProfileFailure extends ProfileState {
  final String errorMessage;
  const EditProfileFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class ChangePasswordLoading extends ProfileState {
  const ChangePasswordLoading();

  @override
  List<Object?> get props => [];
}

class ChangePasswordSuccess extends ProfileState {
  const ChangePasswordSuccess();

  @override
  List<Object?> get props => [];
}

class ChangePasswordFailure extends ProfileState {
  final String errorMessage;
  const ChangePasswordFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
