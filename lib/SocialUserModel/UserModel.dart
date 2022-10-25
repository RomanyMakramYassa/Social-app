//import 'package:cloud_firestore/cloud_firestore.dart';

class SocialUserModel {
  String? name;
  String? phone;
  String? email;
  String? uId;
  String? image;
  String? bio;
  String? cover;
  bool? isEmailVerified;
  SocialUserModel(
      {required this.name,
      required this.phone,
      required this.email,
      required this.uId,
      required this.cover,
      required this.image,
      required this.bio,
      required this.isEmailVerified});
  SocialUserModel.fromjson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    uId = json['uId'];
    bio = json['bio'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'bio': bio,
      'image': image,
      'cover': cover,
      'isEmailVerified': isEmailVerified,
    };
  }
}
