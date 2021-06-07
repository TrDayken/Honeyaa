import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Exception.dart';

import 'dart:io';

class ApiBaseHelper {

// api base url  
final String _baseUrl = "http://127.0.0.1:8000/api/";

  Future<dynamic> get(String url) async {
      var responseJson;
      try {
        final response = await http.get(_baseUrl + url);
        responseJson = _returnResponse(response);
      } on SocketException {
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
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}