sealed class ForgotPasswordEvents {}

class SendEmailEvent extends ForgotPasswordEvents {}

class VerifyCodeEvent extends ForgotPasswordEvents {}

class ResendCodeEvent extends ForgotPasswordEvents {}

class ResetPasswordEvent extends ForgotPasswordEvents {}
