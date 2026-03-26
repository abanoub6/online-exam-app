sealed class ForgotPasswordState {
  const ForgotPasswordState();
}

// ── email step ──────────────────────────────
class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();
}

class ForgotPasswordEmailLoading extends ForgotPasswordState {
  const ForgotPasswordEmailLoading();
}

class ForgotPasswordEmailSuccess extends ForgotPasswordState {
  final String? message;
  const ForgotPasswordEmailSuccess(this.message);
}

class ForgotPasswordEmailFailure extends ForgotPasswordState {
  final String message;
  const ForgotPasswordEmailFailure(this.message);
}

// ── verify step ─────────────────────────────
class ForgotPasswordVerifyLoading extends ForgotPasswordState {
  const ForgotPasswordVerifyLoading();
}

class ForgotPasswordVerifySuccess extends ForgotPasswordState {
  final String? status;
  const ForgotPasswordVerifySuccess(this.status);
}

class ForgotPasswordVerifyFailure extends ForgotPasswordState {
  final String message;
  const ForgotPasswordVerifyFailure(this.message);
}

class ForgotPasswordCodeResent extends ForgotPasswordState {
  const ForgotPasswordCodeResent();
}

// ── reset step ──────────────────────────────
class ForgotPasswordResetLoading extends ForgotPasswordState {
  const ForgotPasswordResetLoading();
}

class ForgotPasswordResetSuccess extends ForgotPasswordState {
  final String? token;
  const ForgotPasswordResetSuccess(this.token);
}

class ForgotPasswordResetFailure extends ForgotPasswordState {
  final String message;
  const ForgotPasswordResetFailure(this.message);
}
