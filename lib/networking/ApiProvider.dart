import 'dart:convert';
import 'package:honeyaa_clientside/bloc/userBloc.dart';
import 'package:honeyaa_clientside/models/Picture.dart';
import 'package:honeyaa_clientside/models/id.dart';
import 'package:http/http.dart' show Client;

import 'package:honeyaa_clientside/models/User.dart';

class ApiProvider {
  Client client = Client();

  // final baseUrl = 'http://127.0.0.1:8000/api';
  final baseUrl = 'http://36f5b03446c3.ngrok.io/api';

  Future<User> getUser(int id) async {
    final response = await client.get(baseUrl + '/person/' + id.toString());

    print(response.body.toString());

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<List<User>> getLike(int id) async {
    final response = await client.get(baseUrl + '/getlike/' + id.toString());

    print(response.body.toString());

    Iterable l = json.decode(response.body);

    List<User> listuser = List<User>.from(l.map((e) => User.fromJson(e)));

    if (response.statusCode == 200) {
      return listuser;
    } else {
      throw Exception('failed to load liked user');
    }
  }

  Future<Picture> getImage(int id) async {
    final response = await client.get(baseUrl + '' + id.toString());

    print(response.body.toString());

    if (response.statusCode == 200) {
      return Picture.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get image URL');
    }
  }

  Future<String> getPicture(int id) async {
    print(baseUrl + '/getpicture/' + id.toString());
    final response = await client.get(baseUrl + '/getpicture/' + id.toString());

    print(response.body.toString());

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      ;
      return map[0]['picture'];
    } else {
      throw Exception('Failed');
    }
  }

  Future<List<User>> getliked(int id) async {
    // final response = await client.get(baseUrl + '/person' );

    final userrespone =
        await client.get(baseUrl + '/getlikedperson/' + id.toString());
    print(baseUrl + '/getlikedperson/' + id.toString());

    Iterable l = json.decode(userrespone.body);

    List<ID> list = List<ID>.from(l.map((e) => ID.fromJson(e)));

    List<User> listuser = [];

    // final userresponse;

    for (ID i in list) {
      final userresponse = await client.get(baseUrl + '/person/' + i.id);

      User u = User.fromJson(json.decode(userresponse.body));

      listuser.add(u);
    }
    // print (map) ;

    if (userrespone.statusCode == 200) {
      return listuser;
    } else {
      throw Exception('list empty');
    }
  }

  Future<List<User>> getSwipe(int id) async {
    final response = await client.get(baseUrl + '/person');

    final userrespone = await client.get(baseUrl + '/person/' + id.toString());

    Iterable l = json.decode(response.body);

    List<User> listuser = List<User>.from(l.map((e) => User.fromJson(e)));
    // print (listuser) ;

    User u = User.fromJson(json.decode(userrespone.body));

    listuser.remove(u);

    print(listuser);
    if (response.statusCode == 200 && userrespone.statusCode == 200) {
      return listuser;
    } else {
      throw Exception('list empty');
    }
  }

  Future<String> getID(String uid) async {
    print(baseUrl + '/getinfo/' + uid);
    final response = await client.get(baseUrl + '/getinfo/' + uid);

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      if (map.length > 0)
        return map[0]['id'].toString();
      else
        return (-1).toString();
    } else
      throw Exception('Failed');
  }

  Future<User> postUser(User user) async {
    final response = await client.post(baseUrl + '/person/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: user.toString());

    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create');
    }
  }
}
