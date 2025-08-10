import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readytogo/Constants/api_constants.dart';

class AuthApi {
  static Future<http.Response> sendGoogleJwtToBackend(String idToken) async {
    final url = Uri.parse('https://${ApiConstants.baseDomain}/${ApiConstants.apiPrefix}account/google-sign-up');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'idToken': idToken}),
    );
  }
}
