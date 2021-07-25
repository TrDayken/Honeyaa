import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/models/UserRegistration.dart';

class User extends Equatable {
  String url;
  String uid;
  String name;
  String oriented;
  String personpicture;
  List<String> matchedPerson;
  List<String> swipeperson;
  List<String> interested;

  User(
      {this.url,
      this.uid,
      this.name,
      this.oriented,
      this.matchedPerson,
      this.personpicture,
      this.interested});

  User.fromUserRegistration(UserRegistration usertype) {
    this.name = usertype.name;
    this.uid = usertype.uid;
    this.personpicture = usertype.localProfilePhotoPath;
    this.oriented = usertype.gender;
    this.interested = usertype.hobby;
  }

  User.fromJson(Map<String, dynamic> json) {
    this.url = json['url'];
    this.uid = json['uid'];
    this.name = json['_name'];
    this.oriented = json['oriented'];
    this.personpicture = json['personpicture'];
    this.matchedPerson = List<String>.from(json['matchedPerson']);
    this.swipeperson = new List<String>.from(json['swipePerson']);
    this.interested = new List<String>.from(json['interested']);
  }

  String toString() {
    print(matchedPerson);
    String result = '';

    String interest = '[@param]';
    String param = '';
    for (int i = 0; i < interested.length; i++) {
      param += '"' + interested[i] + '"' + ',';
    }

    if (param != '') param = param.substring(0, param.length - 1);

    String newinterest = interest.replaceAll("@param", param);

    String matched = '[@param]';
    param = '';

    if (matchedPerson != null) {
      for (int i = 0; i < this.matchedPerson.length; i++) {
        param += '"' + this.matchedPerson[i] + '"' + ',';
      }
    } else
      param = "";
      
    if (param != '') param = param.substring(0, param.length - 1);

    String newmatch = matched.replaceAll("@param", param);

    result =
        '{ "url": "$url", "uid": "$uid", "_name": "$name","personpicture": "$personpicture","matchedPerson" : $newmatch , "oriented": "http://127.0.0.1:8000/api/oriented/10/", "interested": $newinterest}';

    print(result);

    return result;
  }

  @override
  List<Object> get props => [url, uid, name, oriented, swipeperson, interested];
}

// class Post extends Equatable {
//   const Post({required this.id, required this.title, required this.body});

//   final int id;
//   final String title;
//   final String body;

//   @override
//   List<Object> get props => [id, title, body];
// }