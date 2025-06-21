import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Constants/api_constants.dart';
import 'api_exception.dart';

class ApiBaseHelper {
  get({
    required String url,
    required String path,
    Map<String, dynamic>? queryParam,
  }) async {
    print('Api Get, url $path');
    var responseJson;
    try {
      final fullUrl = Uri.https(url, path, queryParam); // Combine URL and path
      final response = await http.get(
        fullUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw InternalServerException('Internal server error');
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
    Future<dynamic> post({
    String? baseUrl,
    required String path,
    Map<String, dynamic>? body,
    String? token,
    Map<String, dynamic>? queryParam,
  }) async {
    print('Api Post, url: $path');
    var responseJson;

    try {
      final uri = Uri.http(
        baseUrl ?? ApiConstants.baseDomain,
        '${ApiConstants.apiPrefix}$path',
        queryParam,
      );

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'X-Request-For': '::1',
          if (token != null && token.isNotEmpty) 'Authorization': token,
        },
        body: json.encode(body),
      );

      print('API Response: ${response.statusCode}');
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No Internet connection');
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  // Future<dynamic> post(
  //     {String? baseUrl,
  //     required String path,
  //     Map<String, dynamic>? body,
  //     String? token,
  //     Map<String, dynamic>? queryParam}) async {
  //   print('Api Post, url $path');
  //   var responseJson;
  //   try {
  //     final response = await http.post(
  //       Uri.https(baseUrl ?? ApiConstants.baseUrl, path, queryParam),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'X-Request-For': '::1',
  //         'Authorization': token ?? "",
  //       },
  //       body: json.encode(body),
  //     );
  //     print('REWPONSEEFKEWNKLFN $response');
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     print('No net');
  //     throw FetchDataException('No Internet connection');
  //   }
  //   print('api post received!');
  //   return responseJson;
  // }
}
