//import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? name;

  String? uId;
  String? image;
  String? datetime;
  String? text;
  String? postimage;
  PostModel({
    required this.name,
    required this.text,
    required this.uId,
    required this.datetime,
    required this.image,
    required this.postimage,
  });
  PostModel.fromjson(Map<String, dynamic> json) {
    name = json['name'];
    text = json['text'];
    postimage = json['postimage'];
    image = json['image'];
    uId = json['uId'];
    datetime = json['datetime'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'datetime': datetime,
      'postimage': postimage,
      'uId': uId,
      'image': image,
      'text': text,
    };
  }
}
