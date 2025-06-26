import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../Constants/api_constants.dart';
import '../Service/api_basehelper.dart';

class SignUpRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<http.Response> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String userName,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String zipCode,
    required String referralCode,
    required File profileImage,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://173.249.27.4:343/api/account/register"),
    );

    request.fields.addAll({
      "FirstName": firstName,
      "LastName": lastName,
      "Email": email,
      "UserName": userName,
      "Password": password,
      "ConfirmPassword": confirmPassword,
      "PhoneNumber": phoneNumber,
      "ZipCode": zipCode,
      "ReferralCode": referralCode,
    });

    request.files.add(
      await http.MultipartFile.fromPath(
        "ProfileImage",
        profileImage.path,
        contentType: MediaType("image", "jpeg"), // Adjust if PNG
      ),
    );

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  /*signUpRepository(String firstName, String lastName,String email, String userName,String password,String confirmPassword,String phoneNumber,String zipCode,String referralCode) async {
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
  }*/
}
