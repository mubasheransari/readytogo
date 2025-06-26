import '../Constants/api_constants.dart';
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
