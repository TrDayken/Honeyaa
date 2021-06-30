import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ID extends Equatable {
  ID({this.id,});

  String id ;

  ID.fromJson(Map<String, dynamic> json) {
    this.id = json["id"].toString();
  }

  @override 
  List <Object> get props => [id]; 
}