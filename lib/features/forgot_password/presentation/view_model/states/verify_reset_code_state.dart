abstract class VerifyResetCodeState {}

class VerifyResetCodeInitial extends VerifyResetCodeState {}

class VerifyResetCodeLoading extends VerifyResetCodeState {}

class VerifyResetCodeCodeResent extends VerifyResetCodeState {}

class VerifyResetCodeSuccess extends VerifyResetCodeState {
  final String? status;
  VerifyResetCodeSuccess(this.status);
}

class VerifyResetCodeFailure extends VerifyResetCodeState {
  final String message;
  VerifyResetCodeFailure(this.message);
}
