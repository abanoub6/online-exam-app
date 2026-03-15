import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/forgot_password/data/models/response/verify_reset_code_response.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/repo/forget_password_repo_contract.dart';
import '../../../../core/errors/failures.dart';

@lazySingleton
class VerifyResetCodeUseCase {
  final ForgetPasswordRepoContract _repository;

  VerifyResetCodeUseCase(this._repository);

  Future<Either<Failure, VerifyResetCodeResponse>> call({
    required String resetCode,
  }) {
    return _repository.verifyResetCode(resetCode: resetCode);
  }
}
