import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/register/api/home_api_client/register_api_client.dart';
import 'package:online_exam_app_v/features/register/data/data_sources/register_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/register/data/models/register_request.dart';
import 'package:online_exam_app_v/features/register/data/models/user_dto.dart';

@Injectable(as: RegisterRemoteDataSourceContract)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSourceContract {
  final RegisterApiClient registerApiClient;

  RegisterRemoteDataSourceImpl(this.registerApiClient);

  @override
  Future<BaseResponse<UserDto>> register(
    RegisterRequest registerRequest,
  ) async {
    try {
      final response = await registerApiClient.register(registerRequest);

      if (response.user != null) {
        return SuccessBaseResponse<UserDto>(data: response.user!);
      } else {
        return ErrorBaseResponse<UserDto>(
          errorMessage: 'Registration failed: No user data received',
        );
      }
    } catch (e) {
      return ErrorBaseResponse<UserDto>.fromException(e);
    }
  }
}
