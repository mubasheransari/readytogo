class ApiConstants {
  static const String baseDomain = "173.249.27.4:343";
  static const String apiPrefix = "api/";
  static const String registerApi = "account/register";
  static const String loginApi = "account/login/request-otp";
  static const String verifyOTPApi = "account/login/verify-otp";
  static const String forgetPasswordForToken = "account/forgot-password";
  static const String forgetPasswordOTPApi =
      "account/forgot-password-request-otp";
  static const String forgetPasswordverifyOTP =
      "account/forgot-password-verify-otp";
  static const String resetforgetPassword = "account/reset-password";
  static const String updateFcmToken = "account/update-fcm-token";
  static const String sendPushNotification = "notification/send-notification";
  static const String getIndividualProfileData = "profile/individual/";
  static const String getProfessionalProfileData = "profile/professional/";

}
