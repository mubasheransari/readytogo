import '../Constants/api_constants.dart';
import '../Service/api_basehelper.dart';

class SignUpRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  signUpRepository() async {
    await _apiBaseHelper.post(
      path: ApiConstants.registerApi,
      body: {
        "firstName": "test",
        "lastName": "abcd",
        "email": "test@gmail.com",
        "userName": "testabcd",
        "password": "Testing1@",
        "confirmPassword": "Testing1@",
        "phoneNumber": "000000000",
        "zipCode": "00990",
        "referralCode": "CODE"
      },
    );
  }
}
