import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/register/data/models/register_request.dart';
import 'package:online_exam_app_v/features/register/data/models/user_dto.dart';

abstract class RegisterRemoteDataSourceContract {
  Future<BaseResponse<UserDto>> register(RegisterRequest requestBody);
}
