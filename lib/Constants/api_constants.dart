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
  static const String getIndividualProfileData =
      "profile/individual"; //10@Testing
  static const String getProfessionalProfileData = "profile/professional/";
  static const String getOrganizationalProfileData = "profile/organization/";
  static const String getAllAssociatedGroups = "api/profile/groups";
  static const String getAllProfessionalProfile = "api/profile/professionals";
  static const String addAffiliationsGroups =
      "profile/individual/affiliations/add";
  static const String removeAffiliationsGroups =
      "profile/individual/affiliations/remove";
  static const String addAffiliationsGroupsProfessional =
      "profile/professional/affiliations/add";
  static const String removeAffiliationsGroupsProfessional =
      "profile/professional/affiliations/remove";
  static const String search = "search/search";
  static const String getSaveSearch = "search/get-saved-searches";
  static const String removeSearch = "search/remove-search";
  static const String addSearch = "search/save-search";
    static const String forgetPasswordRequestSMS =
      "account/forgot-password-request-sms-otp";
}
