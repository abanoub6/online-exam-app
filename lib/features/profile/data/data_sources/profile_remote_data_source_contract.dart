import 'package:online_exam_app_v/features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app_v/features/profile/data/models/change_password_response.dart';
import 'package:online_exam_app_v/features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app_v/features/profile/data/models/profile_response.dart';

abstract interface class ProfileRemoteDataSourceContract {
  Future<UserData> getProfile();
  Future<UserData> editProfile(EditProfileRequest request);
  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request);
}
