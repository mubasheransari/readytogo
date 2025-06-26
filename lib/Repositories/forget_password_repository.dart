import '../Constants/api_constants.dart';
import '../Service/api_basehelper.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordRepository{
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  
   Future<http.Response> requestOTPForgetPassword(
      String email) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.forgetPasswordOTPApi,
      body: {
        "email": email,
      },
    );
  }

   Future<http.Response> verifyOTPForgetPassword(
      String email,String otp,String password) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.forgetPasswordverifyOTP,
      body: {
        "email": email,
        "otp":otp,
        "password":password
      },
    );
  }
}