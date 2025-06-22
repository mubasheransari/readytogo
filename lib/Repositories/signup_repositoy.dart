import '../Constants/api_constants.dart';
import '../Service/api_basehelper.dart';

class SignUpRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  signUpRepository(String firstName, String lastName,String email, String userName,String password,String confirmPassword,String phoneNumber,String zipCode,String referralCode) async {
    await _apiBaseHelper.post(
      path: ApiConstants.registerApi,
      body: {
        "firstName":firstName,
        "lastName": lastName,
        "email": email,
        "userName": userName,
        "password": password,
        "confirmPassword":confirmPassword,
        "phoneNumber": phoneNumber,
        "zipCode": zipCode,
        "referralCode":referralCode
      },
    );
  }
}
