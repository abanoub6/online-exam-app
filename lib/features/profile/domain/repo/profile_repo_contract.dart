import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app_v/features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app_v/features/profile/domain/entities/profile_entity.dart';

abstract interface class ProfileRepoContract {
  Future<BaseResponse<ProfileEntity>> getProfile();
  Future<BaseResponse<ProfileEntity>> editProfile(EditProfileRequest request);
  Future<BaseResponse<String>> changePassword(ChangePasswordRequest request);
}
