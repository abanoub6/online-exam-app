import 'package:online_exam_app_v/config/base_responce/base_responce.dart';
import 'package:online_exam_app_v/features/register/data/models/register_request.dart';
import 'package:online_exam_app_v/features/register/domain/entities/user_entity.dart';

abstract class RegisterRepositoryContract {
  Future<BaseResponse<UserEntity>> register({
    required RegisterRequest registerRequest,
  });
}
