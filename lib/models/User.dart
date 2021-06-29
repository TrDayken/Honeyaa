import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  User ({ this.url, this.uid,  this.name , this.oriented,this.personpicture, this.interested});

  String url; 
  String uid;
  String name;
  String oriented;
  String personpicture;
  List<String> swipeperson;
  List<String> interested;

  User.fromJson(Map<String , dynamic> json) {
    this.url = json['url']; 
    this.uid = json['uid']; 
    this.name = json['_name']; 
    this.oriented = json['oriented']; 
    this.personpicture = json ['personpicture'];
    this.swipeperson = new List<String>.from(json['swipePerson']);
    this.interested = new List<String>.from(json['interested']);
  }

  String toString() {
    String result = '';

    result = '{ "url": "$url", "uid": "$uid", "_name": "$name", "oriented": "$oriented" }';

    return result; 
  }

  @override
  List <Object> get props => [url, uid, name, oriented, swipeperson, interested];
}

// class Post extends Equatable {
//   const Post({required this.id, required this.title, required this.body});

//   final int id;
//   final String title;
//   final String body;

//   @override
//   List<Object> get props => [id, title, body];
// }