import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/core/network/api_error_handler.dart';
import 'package:online_exam_app_v/features/profile/data/data_sources/profile_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app_v/features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app_v/features/profile/domain/entities/profile_entity.dart';
import 'package:online_exam_app_v/features/profile/domain/repo/profile_repo_contract.dart';

@Injectable(as: ProfileRepoContract)
class ProfileRepoImpl implements ProfileRepoContract {
  final ProfileRemoteDataSourceContract _dataSource;
  const ProfileRepoImpl(this._dataSource);

  @override
  Future<BaseResponse<ProfileEntity>> getProfile() async {
    try {
      final response = await _dataSource.getProfile();
      return SuccessBaseResponse(data: response.toEntity());
    } on DioException catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    } catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<BaseResponse<ProfileEntity>> editProfile(
    EditProfileRequest request,
  ) async {
    try {
      final response = await _dataSource.editProfile(request);
      return SuccessBaseResponse(data: response.toEntity());
    } on DioException catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    } catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<BaseResponse<String>> changePassword(
    ChangePasswordRequest request,
  ) async {
    try {
      final response = await _dataSource.changePassword(request);
      return SuccessBaseResponse(data: response.token ?? '');
    } on DioException catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    } catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    }
  }
}
