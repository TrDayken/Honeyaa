

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalModel extends Equatable{
  String url ; 
  String oneSignalUID ; 
  String owner;

  OneSignalModel ( { this.url, this.oneSignalUID, this.owner});

  OneSignalModel.fromJson(Map<String, dynamic > json) 
  {
    this.url = json['url'];
    this.oneSignalUID = json['oneSignalUID'];
    this.owner = json['owner'];
  }

  String toString() {
    String result = '';

    result = '{ "url": "$url", "oneSignalUID": "$oneSignalUID", "owner": "$owner"  }';

    print (result);

    return result; 
  }

  @override
  List<Object> get props => [url, oneSignalUID, owner];
}