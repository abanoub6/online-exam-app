import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_responce.dart';
import 'package:online_exam_app_v/features/register/data/models/register_request.dart';
import 'package:online_exam_app_v/features/register/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/features/register/domain/repo/register_repository_contract.dart';

@injectable
class RegisterUseCase {
  final RegisterRepositoryContract repository;

  RegisterUseCase(this.repository);

  Future<BaseResponse<UserEntity>> call({
    required RegisterRequest registerRequest,
  }) {
    return repository.register(registerRequest: registerRequest);
  }
}
