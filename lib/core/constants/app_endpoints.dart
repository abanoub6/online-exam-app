class AppEndpoints {
  AppEndpoints._();
  static const String baseUrl = "https://exam.elevateegy.com/api/v1";

  /// Auth
  static const String signUp = "/auth/signup";
  static const String signIn = "/auth/signin";
  static const String forgotPassword = "/auth/forgotPassword";
  static const String verifyResetCode = "/auth/verifyResetCode";
  static const String resetPassword = "/auth/resetPassword";
  static const String questions = "/questions";
}
