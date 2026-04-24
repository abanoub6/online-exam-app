import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/core/constants/app_endpoints.dart';
import 'package:online_exam_app_v/features/profile/data/models/change_password_response.dart';
import 'package:online_exam_app_v/features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app_v/features/profile/data/models/profile_response.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_client.g.dart';

@injectable
@RestApi()
abstract interface class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @GET(AppEndpoints.profileData)
  Future<ProfileResponse> getProfile();

  @PUT(AppEndpoints.editProfile)
  Future<ProfileResponse> editProfile(@Body() EditProfileRequest request);

  @PATCH(AppEndpoints.changePassword)
  Future<ChangePasswordResponse> changePassword(
    @Body() Map<String, dynamic> body,
  );
}
