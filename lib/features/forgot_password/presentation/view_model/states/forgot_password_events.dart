sealed class ForgotPasswordEvents {}

class SendEmailEvent extends ForgotPasswordEvents {
  final String email;
  SendEmailEvent(this.email);
}

class VerifyCodeEvent extends ForgotPasswordEvents {
  final String code;
  VerifyCodeEvent(this.code);
}

class ResendCodeEvent extends ForgotPasswordEvents {
  final String email;
  ResendCodeEvent(this.email);
}

class ResetPasswordEvent extends ForgotPasswordEvents {
  final String email;
  final String password;
  ResetPasswordEvent(this.email, this.password);
}
