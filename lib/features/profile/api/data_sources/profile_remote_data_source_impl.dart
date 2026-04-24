import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/profile/api/profile_api_client/profile_api_client.dart';
import 'package:online_exam_app_v/features/profile/data/data_sources/profile_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app_v/features/profile/data/models/change_password_response.dart';
import 'package:online_exam_app_v/features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app_v/features/profile/data/models/profile_response.dart';

@Injectable(as: ProfileRemoteDataSourceContract)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSourceContract {
  final ProfileApiClient _apiClient;
  const ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserData> getProfile() async {
    final response = await _apiClient.getProfile();
    return response.user;
  }

  @override
  Future<UserData> editProfile(EditProfileRequest request) async {
    final response = await _apiClient.editProfile(request);
    return response.user;
  }

  @override
  Future<ChangePasswordResponse> changePassword(
    ChangePasswordRequest request,
  ) async {
    final response = await _apiClient.changePassword(request.toJson());
    return response;
  }
}
