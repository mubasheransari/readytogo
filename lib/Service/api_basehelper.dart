import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Constants/api_constants.dart';
import 'api_exception.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ApiBaseHelper {
  bool _wasConnected = true;

  Future<dynamic> get({
    required String url,
    required String path,
    Map<String, dynamic>? queryParam,
  }) async {
    print('Api GET -> url: $url, path: $path');

    final hasInternet = await _checkConnectionWithToast();
    if (!hasInternet) {
      throw FetchDataException('No Internet connection');
    }

    try {
      final uri =
          Uri.parse("http://$url/$path").replace(queryParameters: queryParam);
      print("Final URI: $uri");

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      return _returnResponse(response);
    } on SocketException catch (e) {
      print('SocketException: $e');
      await _checkConnectionWithToast();
      throw FetchDataException('No Internet connection');
    }
  }

  Future<http.Response> delete({
    String? baseUrl,
    required String path,
    Map<String, dynamic>? body,
    String? token,
    Map<String, dynamic>? queryParam,
  }) async {
    print('Api DELETE -> path: $path');

    final hasInternet = await _checkConnectionWithToast();
    if (!hasInternet) {
      throw FetchDataException('No Internet connection');
    }

    try {
      final uri = Uri.http(
        baseUrl ?? ApiConstants.baseDomain,
        '${ApiConstants.apiPrefix}$path',
        queryParam,
      );

      final request = http.Request("DELETE", uri);
      request.headers.addAll({
        'Content-Type': 'application/json',
        'X-Request-For': '::1',
        if (token != null && token.isNotEmpty) 'Authorization': token,
      });

      if (body != null) {
        request.body = json.encode(body);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('API DELETE Response: ${response.statusCode}');
      return response;
    } on SocketException catch (e) {
      print('SocketException: $e');
      await _checkConnectionWithToast();
      throw FetchDataException('No Internet connection');
    }
  }

  Future<http.Response> post({
    String? baseUrl,
    required String path,
    Map<String, dynamic>? body,
    String? token,
    Map<String, dynamic>? queryParam,
  }) async {
    print('Api POST -> path: $path');

    final hasInternet = await _checkConnectionWithToast();
    if (!hasInternet) {
      throw FetchDataException('No Internet connection');
    }

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

      print('API POST Response: ${response.statusCode}');
      return response;
    } on SocketException catch (e) {
      print('SocketException: $e');
      await _checkConnectionWithToast();
      throw FetchDataException('No Internet connection');
    }
  }

  /// Checks internet and shows toast if status changes
  Future<bool> _checkConnectionWithToast() async {
    final isConnected = await _hasInternet();
    if (!isConnected && _wasConnected) {
      _showNoInternetToast();
    } else if (isConnected && !_wasConnected) {
      _showInternetRestoredToast();

      // Show error occurred toast after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        _showErrorOccurredToast();
      });
    }
    _wasConnected = isConnected;
    return isConnected;
  }

  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Actual Internet check passed');
        return true;
      }
    } catch (e) {
      print('Internet check failed: $e');
    }
    return false;
  }

  /* Future<bool> _hasInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    print('Connectivity result: $connectivityResult');

    if (connectivityResult == ConnectivityResult.none) {
      print('Connectivity: No connection');
      return false;
    }

    try {
      final result = await InternetAddress.lookup('google.com').timeout(
        const Duration(seconds: 4),
      );

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('DNS lookup successful, connected to internet');
        return true;
      } else {
        print('DNS lookup failed');
        return false;
      }
    } on SocketException catch (e) {
      print('DNS lookup socket error: $e');
      return false;
    } on TimeoutException {
      print('DNS lookup timed out');
      return false;
    }
  }*/

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
            'Error communicating with server: ${response.statusCode}');
    }
  }

  void _showNoInternetToast() {
    Fluttertoast.showToast(
      msg: "No internet connection available",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showInternetRestoredToast() {
    Fluttertoast.showToast(
      msg: "Internet connection restored",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showErrorOccurredToast() {
    Fluttertoast.showToast(
      msg: "Error occurred",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

/*class ApiBaseHelper {
  bool _wasConnected = true; // tracks previous state

  Future<dynamic> get({
    required String url,
    required String path,
    Map<String, dynamic>? queryParam,
  }) async {
    print('Api GET -> url: $url, path: $path');

    final hasInternet = await _checkConnectionWithToast();
    if (!hasInternet) {
      throw FetchDataException('No Internet connection');
    }

    try {
      final uri =
          Uri.parse("http://$url/$path").replace(queryParameters: queryParam);
      print("Final URI: $uri");

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      return _returnResponse(response);
    } on SocketException catch (e) {
      print('SocketException: $e');
      await _checkConnectionWithToast(); // re-check on exception
      throw FetchDataException('No Internet connection');
    }
  }

  Future<http.Response> delete({
    String? baseUrl,
    required String path,
    Map<String, dynamic>? body,
    String? token,
    Map<String, dynamic>? queryParam,
  }) async {
    print('Api Delete, url: $path');

    final hasInternet = await _checkConnectionWithToast();
    if (!hasInternet) {
      throw FetchDataException('No Internet connection');
    }

    try {
      final uri = Uri.http(
        baseUrl ?? ApiConstants.baseDomain,
        '${ApiConstants.apiPrefix}$path',
        queryParam,
      );

      final request = http.Request("DELETE", uri);
      request.headers.addAll({
        'Content-Type': 'application/json',
        'X-Request-For': '::1',
        if (token != null && token.isNotEmpty) 'Authorization': token,
      });

      if (body != null) {
        request.body = json.encode(body);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('API DELETE Response: ${response.statusCode}');
      return response;
    } on SocketException catch (e) {
      print('SocketException: $e');
      await _checkConnectionWithToast();
      throw FetchDataException('No Internet connection');
    }
  }

  Future<http.Response> post({
    String? baseUrl,
    required String path,
    Map<String, dynamic>? body,
    String? token,
    Map<String, dynamic>? queryParam,
  }) async {
    print('Api Post, url: $path');

    final hasInternet = await _checkConnectionWithToast();
    if (!hasInternet) {
      throw FetchDataException('No Internet connection');
    }

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
      return response;
    } on SocketException catch (e) {
      print('SocketException: $e');
      await _checkConnectionWithToast();
      throw FetchDataException('No Internet connection');
    }
  }

  /// 10@TestingChecks internet and shows toast if status changed
  Future<bool> _checkConnectionWithToast() async {
    final isConnected = await _hasInternet();
    if (!isConnected && _wasConnected) {
      _showNoInternetToast();
    } else if (isConnected && !_wasConnected) {
      _showInternetRestoredToast();
    }
    _wasConnected = isConnected;
    return isConnected;
  }
  Future<bool> _hasInternet() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }

  try {
    final result = await http.get(
      Uri.parse('https://clients3.google.com/generate_204'),
    ).timeout(Duration(seconds: 4));

    return result.statusCode == 204;
  } catch (e) {
    print("Internet check failed: $e");
    return false;
  }
}*/

// Future<bool> _hasInternet() async {
//   var connectivityResult = await Connectivity().checkConnectivity();
//   if (connectivityResult == ConnectivityResult.none) {
//     return false;
//   }

//   try {
//     final result = await InternetAddress.lookup('example.com')
//         .timeout(const Duration(seconds: 3));
//     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       return true;
//     }
//   } catch (_) {}

//   try {
//     final response = await http
//         .get(Uri.parse('https://www.google.com'))
//         .timeout(const Duration(seconds: 5));
//     return response.statusCode == 200;
//   } catch (_) {
//     return false;
//   }
// }

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
          'Error while communicating with server: ${response.statusCode}');
  }
}

void _showNoInternetToast() {
  Fluttertoast.showToast(
    msg: "No internet connection available",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.redAccent,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void _showInternetRestoredToast() {
  Fluttertoast.showToast(
    msg: "Internet connection restored",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}



/*class ApiBaseHelper {
  Future<dynamic> get({
    required String url,
    required String path,
    Map<String, dynamic>? queryParam,
  }) async {
    print('Api GET -> url: $url, path: $path');

    final hasInternet = await _hasInternet();
    if (!hasInternet) {
      _showNoInternetToast();
      throw FetchDataException('No Internet connection');
    }

    try {
      final uri =
          Uri.parse("http://$url/$path").replace(queryParameters: queryParam);
      print("Final URI: $uri");

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      return _returnResponse(response);
    } on SocketException catch (e) {
      print('SocketException: $e');
      if (!await _hasInternet()) {
        _showNoInternetToast();
      }
      throw FetchDataException('No Internet connection');
    }
  }


  Future<http.Response> delete({
  String? baseUrl,
  required String path,
  Map<String, dynamic>? body,
  String? token,
  Map<String, dynamic>? queryParam,
}) async {
  print('Api Delete, url: $path');

  final hasInternet = await _hasInternet();
  if (!hasInternet) {
    _showNoInternetToast();
    throw FetchDataException('No Internet connection');
  }

  try {
    final uri = Uri.http(
      baseUrl ?? ApiConstants.baseDomain,
      '${ApiConstants.apiPrefix}$path',
      queryParam,
    );

    final request = http.Request("DELETE", uri);
    request.headers.addAll({
      'Content-Type': 'application/json',
      'X-Request-For': '::1',
      if (token != null && token.isNotEmpty) 'Authorization': token,
    });

    if (body != null) {
      request.body = json.encode(body);
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('API DELETE Response: ${response.statusCode}');
    return response;
  } on SocketException catch (e) {
    print('SocketException: $e');
    if (!await _hasInternet()) {
      _showNoInternetToast();
    }
    throw FetchDataException('No Internet connection');
  }
}


  Future<http.Response> post({
    String? baseUrl,
    required String path,
    Map<String, dynamic>? body,
    String? token,
    Map<String, dynamic>? queryParam,
  }) async {
    print('Api Post, url: $path');

    final hasInternet = await _hasInternet();
    if (!hasInternet) {
      _showNoInternetToast();
      throw FetchDataException('No Internet connection');
    }

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
      return response; // <-- Return full response now
    } on SocketException catch (e) {
      print('SocketException: $e');
      if (!await _hasInternet()) {
        _showNoInternetToast();
      }
      throw FetchDataException('No Internet connection');
    }
  }


  Future<bool> _hasInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    try {
      final result = await InternetAddress.lookup('example.com')
          .timeout(const Duration(seconds: 3));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (_) {}

    try {
      final response = await http
          .get(
            Uri.parse('https://www.google.com'),
          )
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
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
            'Error while communicating with server: ${response.statusCode}');
    }
  }

  void _showNoInternetToast() {
    Fluttertoast.showToast(
      msg: "No internet connection available",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
*/