abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final String? token;
  ResetPasswordSuccess(this.token);
}

class ResetPasswordFailure extends ResetPasswordState {
  final String message;
  ResetPasswordFailure(this.message);
}
