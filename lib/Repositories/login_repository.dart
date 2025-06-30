import '../Constants/api_constants.dart';
import '../Model/individual_profile_model.dart';
import '../Service/api_basehelper.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<http.Response> loginWithEmailPassword(
      String email, String password) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.loginApi,
      body: {
        "email": email,
        "password": password,
      },
    );
  }

    Future<http.Response> verifyOTP(
      String email, String password, String otp) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.verifyOTPApi,
      body: {
        "email": email,
        "password": password,
        "otp": otp,
      },
    );
  }
Future<IndividualProfileModel> individualProfile(String userId) async {
  final jsonResponse = await _apiBaseHelper.get(
    url: ApiConstants.baseDomain,
    path: "${ApiConstants.apiPrefix}${ApiConstants.getIndividualProfileData}$userId",
    queryParam: {},
  );

  return IndividualProfileModel.fromJson(jsonResponse);
}



  // loginWithEmailPassword(String email, String password) async {
  //   await _apiBaseHelper.post(
  //     path: ApiConstants.loginApi,
  //     body: {
  //       "email": email,
  //       "password": password,
  //     },
  //   );
  // }
}
