import 'package:get_storage/get_storage.dart';

import '../Constants/api_constants.dart';
import '../Service/api_basehelper.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<http.Response> requestOTPForgetPassword(String email) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.forgetPasswordOTPApi,
      body: {
        "email": email,
      },
    );
  }

  Future<http.Response> forgetPasswordToken(String email) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.forgetPasswordForToken,
      body: {
        "email": email,
      },
    );
  }

  Future<http.Response> verifyOTPForgetPassword(
      String email, String otp) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.forgetPasswordverifyOTP,
      body: {"email": email, "otp": otp, "password": ""},
    );
  }

  Future<http.Response> resetForgetPassword(
      String email, String password, String confirmPassword) async {
    var storage = GetStorage();
    var token = storage.read("token-forgetPassword");
    return await _apiBaseHelper.post(
      path: ApiConstants.resetforgetPassword,
      body: {
        "email": email,
        "token": token,
        "newPassword": password,
        "confirmPassword": confirmPassword
      },
    );
  }

    Future<http.Response> requestForgetPasswordThroughSMS(String phone) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.forgetPasswordRequestSMS,
      body: {
        "phoneNumber": phone,
      },
    );
  }
}
