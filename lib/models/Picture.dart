import 'package:equatable/equatable.dart';

class Picture extends Equatable {
  Picture ({this.url, this.picture, this.owner});

  String url ; 
  String picture; 
  String owner;

  Picture.fromJson(Map<String, dynamic> json) {
    this.url = json['url'];
    this.picture = json['picture'];
    this.owner = json['owner'];
  }

  String toString() {
    String result = '';

    result = '{ "url": "$url", "picture": "$picture", "owner": "$owner" }';

    return result;
  }

  @override 
  List<Object> get props => [url, picture, owner];
}