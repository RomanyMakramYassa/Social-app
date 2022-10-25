//import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? datetime;
  String? text;
  String? senderId;
  String? receiverId;

  MessageModel({
    required this.text,
    required this.datetime,
    required this.receiverId,
    required this.senderId,
  });
  MessageModel.fromjson(Map<String, dynamic> json) {
    text = json['text'];
    datetime = json['datetime'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'datetime': datetime,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }
}
