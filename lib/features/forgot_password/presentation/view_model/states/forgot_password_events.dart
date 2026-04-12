sealed class ForgotPasswordEvents {}

class SendEmailEvent extends ForgotPasswordEvents {
  final String email;
  SendEmailEvent(this.email);
}

class VerifyCodeEvent extends ForgotPasswordEvents {}

class ResendCodeEvent extends ForgotPasswordEvents {}

class ResetPasswordEvent extends ForgotPasswordEvents {
  final String password;
  ResetPasswordEvent(this.password);
}
