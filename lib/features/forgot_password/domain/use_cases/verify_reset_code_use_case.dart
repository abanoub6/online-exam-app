import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_responce.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/entities/forget_password_entity.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/repo/forget_password_repo_contract.dart';

@lazySingleton
class VerifyResetCodeUseCase {
  final ForgetPasswordRepoContract _repository;

  VerifyResetCodeUseCase(this._repository);

  Future<BaseResponse<ForgotPasswordEntity>> call({required String resetCode}) {
    return _repository.verifyResetCode(resetCode: resetCode);
  }
}
