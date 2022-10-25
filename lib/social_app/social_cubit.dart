import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:socialapp/social_app/social_state.dart';

import '../SocialUserModel/UserModel.dart';
import '../SocialUserModel/messagemodel.dart';
import '../SocialUserModel/postmodel.dart';
import '../chats/chats.dart';
import '../feeds/feeds.dart';
import '../newpost/newpost.dart';
import '../settings/settings.dart';
import '../users/users.dart';
import 'costant.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialIntialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? model;
  // SocialUserModel? userModel;
  void GetUser() {
    emit(SocialGetuserLoadingState());
    FirebaseFirestore.instance.collection('user').doc(uid).get().then((value) {
      model = SocialUserModel.fromjson(value.data()!);
      print(value.data());
      emit(SocialGetuserSucceesState());
    }).catchError((onError) {
      emit(SocialGetUserErrorState(onError.toString()));
    });
  }

  int Currentindex = 0;
  List<Widget> SocialScreen = [
    FeedsScreen(),
    ChatsScreen(),
    NewPost(),
    UsersScreen(),
    SettingsScreen()
  ];
  List<String> Title = ['Home', 'Chats', 'new', 'Users', 'Setting'];
  void changeBottonnav(int index) {
    if (index == 1) {
      getuser();
    }
    if (index == 2) {
      emit(SocialAddNewPostState());
    } else {
      Currentindex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? ProfileImage;
  var picker = ImagePicker();
  Future<void> getprofileimage() async {
    final packedimage = await picker.getImage(source: ImageSource.gallery);
    if (packedimage != null) {
      ProfileImage = File(packedimage.path);
      emit(SociaprofileImagepackedSuccessState());
    } else {
      print('no image  selected');
      emit(SociaprofileImagepackedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCovereimage() async {
    final packedimage = await picker.getImage(source: ImageSource.gallery);
    if (packedimage != null) {
      coverImage = File(packedimage.path);
      emit(SocialCoverImagepackedSuccessState());
    } else {
      print('no image  selected');
      emit(SocialCoverImagepackedErrorState());
    }
  }

  String Profileimageurl = ' ';

  void uplaodprofileimage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialuserupdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!)
        .then((vval) {
      vval.ref.getDownloadURL().then((value) {
        Profileimageurl = value;
        updateUser(name: name, phone: phone, bio: bio, image: value);
        // emit(SocialuploadprofileImageSuccessState());
        print(value.toString());
      }).catchError((onError) {
        emit(SocialuploadprofileImageErrorState());
        print(onError.toString());
      });
    }).catchError((onError) {
      emit(SocialuploadprofileImageErrorState());
    });
  }

  String CoverImageUrl = ' ';
  void uploadCoverimage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialuserupdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        CoverImageUrl = value;
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        //emit(SocialuploadCoverImageSuccessState());
        print(value);
      }).catchError((onError1) {
        emit(SocialuploadCoverImageErrorState());
        print(onError1);
      });
    }).catchError((onError) {
      emit(SocialuploadCoverImageErrorState());
      print(onError);
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel modele = SocialUserModel(
      name: name,
      phone: phone,
      uId: model!.uId,
      bio: bio,
      isEmailVerified: false,
      email: model!.email,
      cover: cover ?? model!.cover,
      image: image ?? model!.image,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(model!.uId)
        .update(modele.toMap())
        .then((value) {
      GetUser();
    }).catchError((onerror) {
      emit(SocialuserupdateErrorState());
    });
  }

/**
  void updateUserimage({
    required String name,
    required String phone,
    required String bio,
  }) {
    if (coverImage != null) {
      // uploadCoverimage();
    } else if (ProfileImage != null) {
      //uplaodprofileimage();
    } else if (coverImage != null && ProfileImage != null) {
    } else {
      updateUser(name: name, phone: phone, bio: bio);
    }
  }*/
//postcrate
  File? PostImage;
  Future<void> getPostimage() async {
    final packedimage = await picker.getImage(source: ImageSource.gallery);
    if (packedimage != null) {
      PostImage = File(packedimage.path);
      emit(SocialPostImagepackedSuccessState());
    } else {
      print('no image  selected');
      emit(SocialPostImagepackedErrorState());
    }
  }

  void uploadPostimage({
    required String datetime,
    required String text,
  }) {
    emit(SocialCreatepostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        //emit(SocialuploadCoverImageSuccessState());
        CreatePost(datetime: datetime, text: text, PostImage: value);
        print(value);
      }).catchError((onError1) {
        emit(SocialCreatepostErrorState());
        print(onError1);
      });
    }).catchError((onError) {
      emit(SocialCreatepostErrorState());
      print(onError);
    });
  }

  void CreatePost(
      {required String datetime, required String text, String? PostImage}) {
    PostModel modele = PostModel(
        name: model!.name,
        text: text,
        uId: model!.uId,
        datetime: datetime,
        image: model!.image,
        postimage: PostImage ?? ' ');
    FirebaseFirestore.instance
        .collection('post')
        .add(modele.toMap())
        .then((value) {
      emit(SocialCreatepostSuccessState());
    }).catchError((onerror) {
      emit(SocialCreatepostErrorState());
    });
  }

  void removePostimage() {
    PostImage = null;
    emit(SocialremovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postid = [];
  List<int> likes = [];
  List<int> comments = [];
  void getPosts() {
    FirebaseFirestore.instance.collection('post').get().then((value) {
      value.docs.forEach((element) {
        postid.add(element.id);
        posts.add(PostModel.fromjson(element.data()));

        element.reference.collection('like').get().then((value) {
          likes.add(value.docs.length);
        }).catchError((onError) {});
        element.reference.collection('coment').get().then((value) {
          comments.add(value.docs.length);
        }).catchError((onError) {});
      });
      emit(SocialGetpostSucceesState());
    }).catchError((onError) {
      emit(SocialGetpostErrorState(onError.toString()));
    });
  }

  void likepost(String postid) {
    FirebaseFirestore.instance
        .collection('post')
        .doc(postid)
        .collection('like')
        .doc(model!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialPostlikeSucceesState());
    }).catchError((onError) {
      emit(SocialPostlikeErrorState(onError.toString()));
    });
  }

  void comentpost(String postid, String text) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('coment')
        .doc(model!.uId)
        .set({
      'coment': text,
    }).then((value) {
      emit(SocialPostcommentSucceesState());
    }).catchError((onError) {
      emit(SocialPostcommentErrorState(onError.toString()));
    });
  }

  List<SocialUserModel> users = [];
  void getuser() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('user').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != model!.uId)
            users.add(SocialUserModel.fromjson(element.data()));
        });
        emit(SocialGetalluserSucceesState());
      }).catchError((onError) {
        emit(SocialGetallUserErrorState(onError.toString()));
      });
  }

  void SendMessage({
    required String text,
    required String receiverId,
    required String datetime,
  }) {
    MessageModel mmodel = MessageModel(
        text: text,
        datetime: datetime,
        receiverId: receiverId,
        senderId: model!.uId);

    FirebaseFirestore.instance
        .collection('user')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(mmodel.toMap())
        .then((value) {
      emit(SocialSendMessageSucceesState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('user')
        .doc(receiverId)
        .collection('chat')
        .doc(model!.uId)
        .collection('message')
        .add(mmodel.toMap())
        .then((value) {
      emit(SocialSendMessageSucceesState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> message = [];
  void getmessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(model!.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .orderBy('datetime')
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(MessageModel.fromjson(element.data()));
      });
      emit(SocialGetMessageSucceesState());
    });
  }
}
