import 'package:equatable/equatable.dart';
import 'package:online_exam_app_v/features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app_v/features/profile/data/models/edit_profile_request.dart';

sealed class ProfileEvents extends Equatable {
  const ProfileEvents();
}

class GetProfileEvent extends ProfileEvents {
  const GetProfileEvent();

  @override
  List<Object?> get props => [];
}

class EditProfileEvent extends ProfileEvents {
  final EditProfileRequest request;
  const EditProfileEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class ChangePasswordEvent extends ProfileEvents {
  final ChangePasswordRequest request;
  const ChangePasswordEvent(this.request);

  @override
  List<Object?> get props => [request];
}
