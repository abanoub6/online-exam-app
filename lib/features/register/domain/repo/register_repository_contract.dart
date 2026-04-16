import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/register/data/models/register_request.dart';
import 'package:online_exam_app_v/features/register/domain/entities/user_entity.dart';

abstract interface class RegisterRepositoryContract {
  Future<BaseResponse<UserEntity>> register({
    required RegisterRequest registerRequest,
  });
}
