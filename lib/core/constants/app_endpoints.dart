abstract class AppEndpoints {
  static const String baseUrl = "https://exam.elevateegy.com/api/v1";

  /// Auth
  static const String signUp = "/auth/signup";
  static const String signIn = "/auth/signin";
  static const String forgotPassword = "/auth/forgotPassword";
  static const String verifyResetCode = "/auth/verifyResetCode";
  static const String resetPassword = "/auth/resetPassword";
  static const String questions = "/questions";
  static const String getAllExams = "/exams";
  static const String subjects = "/subjects";
  static const String profileData = '/auth/profileData';
  static const String editProfile = '/auth/editProfile';
  static const String changePassword = '/auth/changePassword';
}
