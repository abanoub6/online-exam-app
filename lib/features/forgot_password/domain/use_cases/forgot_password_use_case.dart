import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/entities/forget_password_entity.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/repo/forget_password_repo_contract.dart';

@lazySingleton
class ForgotPasswordUseCase {
  final ForgetPasswordRepoContract _repository;

  ForgotPasswordUseCase(this._repository);

  Future<BaseResponse<ForgotPasswordEntity>> call({required String email}) {
    return _repository.forgotPassword(email: email);
  }
}
