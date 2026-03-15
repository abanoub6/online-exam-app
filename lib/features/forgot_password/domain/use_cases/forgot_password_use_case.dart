import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/forgot_password_response.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/repo/forget_password_repo_contract.dart';
import '../../../../core/errors/failures.dart';

@lazySingleton
class ForgotPasswordUseCase {
  final ForgetPasswordRepoContract _repository;

  ForgotPasswordUseCase(this._repository);

  Future<Either<Failure, ForgotPasswordResponse>> call({
    required String email,
  }) {
    return _repository.forgotPassword(email: email);
  }
}
