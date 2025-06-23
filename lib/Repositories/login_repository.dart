import '../Constants/api_constants.dart';
import '../Service/api_basehelper.dart';

class LoginRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  loginWithEmailPassword(String email, String password) async {
    await _apiBaseHelper.post(
      path: ApiConstants.loginApi,
      body: {
        "email": email,
        "password": password,
      },
    );
  }
}
