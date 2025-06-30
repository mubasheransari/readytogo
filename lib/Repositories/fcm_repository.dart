import 'package:get_storage/get_storage.dart';
import "package:http/http.dart" as http;
import '../Constants/api_constants.dart';
import '../Service/api_basehelper.dart';

class FcmRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<http.Response> updateFcmToken(String userId) async {
    var box = GetStorage();
    var value = box.read("fcm_token");
    return await _apiBaseHelper.post(
        path: ApiConstants.updateFcmToken,
        body: {"userId": userId, "fcmToken": value});
  }

  Future<http.Response> sendPushNotification(String userId) async {
    var box = GetStorage();
    var value = box.read("fcm_token");
    return await _apiBaseHelper.post(
        path: ApiConstants.sendPushNotification,
        body: {
          "userId": userId,
          "title": "Test",
          "message": "testing",
          "iconType": "dsvdsvd"
        });
  }

  // Future<void> sendPushNotification(String targetToken) async {
  //   const String serverKey =
  //       'YOUR_FCM_SERVER_KEY_HERE'; // 🔥 Don't use this in production
  //   const String fcmEndpoint = 'https://fcm.googleapis.com/fcm/send';

  //   final response = await http.post(
  //     Uri.parse(fcmEndpoint),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'key=$serverKey',
  //     },
  //     body: jsonEncode({
  //       'to': targetToken,
  //       'notification': {
  //         'title': 'Hello',
  //         'body': 'This is a test push from the app.',
  //       },
  //       'data': {
  //         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //       },
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     print('✅ Push sent successfully');
  //   } else {
  //     print('❌ Failed to send push: ${response.body}');
  //   }
  // }
}
