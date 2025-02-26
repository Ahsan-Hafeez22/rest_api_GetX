import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:rest_api_project/data/app_exceptions.dart';
import 'package:rest_api_project/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {
  @override
  Future<dynamic> getApi(String url) async {
    try {
      dynamic response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      log(response.statusCode.toString());
      return _processResponse(response);
    } on SocketException {
      throw InternetException("No Internet Connection");
    } on RequestTimeoutException {
      throw RequestTimeoutException("Request Timed Out");
    } catch (e) {
      throw ServerException("Unexpected Error: $e");
    }
  }

  @override
  Future postApi(String url, Map<String, dynamic> data) async {
    try {
      final response =
          await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
        'Content-Type': 'application/json',
      }).timeout(const Duration(seconds: 10));
      return _processResponse(response);
    } on SocketException {
      throw InternetException("No Internet Connection");
    } on RequestTimeoutException {
      throw RequestTimeoutException("Request Timed Out");
    } catch (e) {
      throw ServerException("Unexpected Error: $e");
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body); // Return parsed JSON response
      case 400:
        throw BadRequestException("Bad Request");
      case 401:
      case 403:
        throw UnauthorizedException("Unauthorized Access");
      case 404:
        throw NotFoundException("Resource Not Found");
      case 500:
      default:
        throw ServerException("Server Error: ${response.statusCode}");
    }
  }
}
