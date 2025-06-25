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
  Future<dynamic> get({
    required String url,
    required String path,
    Map<String, dynamic>? queryParam,
  }) async {
    print('Api Get, url: $path');
    var responseJson;

    final hasInternet = await _hasInternet();
    if (!hasInternet) {
      _showNoInternetToast();
      throw FetchDataException('No Internet connection');
    }

    try {
      final fullUrl = Uri.https(url, path, queryParam);
      final response = await http.get(
        fullUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException catch (e) {
      print('SocketException: $e');
      if (!await _hasInternet()) {
        _showNoInternetToast();
      }
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
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


  // Future<dynamic> post({
  //   String? baseUrl,
  //   required String path,
  //   Map<String, dynamic>? body,
  //   String? token,
  //   Map<String, dynamic>? queryParam,
  // }) async {
  //   print('Api Post, url: $path');
  //   var responseJson;

  //   final hasInternet = await _hasInternet();
  //   if (!hasInternet) {
  //     _showNoInternetToast();
  //     throw FetchDataException('No Internet connection');
  //   }

  //   try {
  //     final uri = Uri.http(
  //       baseUrl ?? ApiConstants.baseDomain,
  //       '${ApiConstants.apiPrefix}$path',
  //       queryParam,
  //     );

  //     final response = await http.post(
  //       uri,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'X-Request-For': '::1',
  //         if (token != null && token.isNotEmpty) 'Authorization': token,
  //       },
  //       body: json.encode(body),
  //     );

  //     print('API Response: ${response.statusCode}');
  //     responseJson = _returnResponse(response);
  //   } on SocketException catch (e) {
  //     print('SocketException: $e');
  //     if (!await _hasInternet()) {
  //       _showNoInternetToast();
  //     }
  //     throw FetchDataException('No Internet connection');
  //   }

  //   return responseJson;
  // }

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
      final response = await http.get(
        Uri.parse('https://www.google.com'),
      ).timeout(const Duration(seconds: 5));
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