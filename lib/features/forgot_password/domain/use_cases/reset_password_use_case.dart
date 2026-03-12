import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/reset_password_response.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/repo/forget_password_repo_contract.dart';
import '../../../../core/errors/failures.dart';

@lazySingleton
class ResetPasswordUseCase {
  final ForgetPasswordRepoContract _repository;

  ResetPasswordUseCase(this._repository);

  Future<Either<Failure, ResetPasswordResponse>> call({
    required String email,
    required String newPassword,
  }) {
    return _repository.resetPassword(email: email, newPassword: newPassword);
  }
}
