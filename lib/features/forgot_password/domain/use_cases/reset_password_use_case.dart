import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_responce.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/entities/forget_password_entity.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/repo/forget_password_repo_contract.dart';

@lazySingleton
class ResetPasswordUseCase {
  final ForgetPasswordRepoContract _repository;

  ResetPasswordUseCase(this._repository);

  Future<BaseResponse<ForgotPasswordEntity>> call({
    required String email,
    required String newPassword,
  }) {
    return _repository.resetPassword(email: email, newPassword: newPassword);
  }
}
