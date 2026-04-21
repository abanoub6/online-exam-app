import 'package:online_exam_app_v/features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app_v/features/profile/data/models/edit_profile_request.dart';

sealed class ProfileEvents {}

class GetProfileEvent extends ProfileEvents {}

class EditProfileEvent extends ProfileEvents {
  final EditProfileRequest request;
  EditProfileEvent(this.request);
}

class ChangePasswordEvent extends ProfileEvents {
  final ChangePasswordRequest request;
  ChangePasswordEvent(this.request);
}
