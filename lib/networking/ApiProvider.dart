import 'dart:convert';
import 'package:honeyaa_clientside/models/Picture.dart';
import 'package:http/http.dart' show Client;

import 'package:honeyaa_clientside/models/User.dart';

class ApiProvider {
  Client client = Client();

  // final _baseUrl = 'http://127.0.0.1:8000/api';
  final _baseUrl = 'http://2426aab9675b.ngrok.io/api';

  Future<User> getUser(int id) async {
    final response = await client.get(_baseUrl + '/person/' + id.toString());

    print(response.body.toString());

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Picture> getImage(int id) async {
    final response = await client.get(_baseUrl + '' + id.toString());

    print(response.body.toString());

    if(response.statusCode == 200) {
      return Picture.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get image URL');
    }
  }
}
