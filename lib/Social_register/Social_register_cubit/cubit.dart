import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/Social_register/Social_register_cubit/stats.dart';

import '../../../../shared/network/remote/diohelper.dart';
import '../../SocialUserModel/UserModel.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStat> {
  SocialRegisterCubit() : super(SocialRegisterIntialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void RegisterLogin(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    print('hallo');
    emit(SocialRegisterLoadingState());
    print('hallo2');
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('sucess in regester cubit ');
      UserCreate(email: email, uId: value.user!.uid, name: name, phone: phone);
      // emit(SocialRegisterSucessState());
      print('success create user');
      //print(value.user!.email);
      //print(value.user!.uid);
    }).catchError((eror) {
      emit(SocialRegistererorState(eror.toString()));
    });
  }

  void UserCreate(
      {required String email,
      required String uId,
      required String name,
      required String phone}) {
    SocialUserModel model = SocialUserModel(
        name: name,
        phone: phone,
        email: email,
        cover:
            'https://as1.ftcdn.net/v2/jpg/03/18/04/06/1000_F_318040627_JUtj3w0UzkeT5QqUk37Ys9iK2ZF26QaG.jpg',
        image:
            'https://t4.ftcdn.net/jpg/04/17/35/85/240_F_417358500_mmtE6Gkk5zMYN6jGQu7g27WNkCNscW5F.jpg',
        uId: uId,
        bio: 'write your bio ...',
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      print('3aaa4');
      emit(SocialCreateRegisterSucessState());
    }).catchError((onError) {
      emit(SocialCreateRegistererorState(onError.toString()));
    });
  }

  Icon sufix = Icon(Icons.visibility_outlined);
  bool IsPass = true;
  void changrsufix() {
    IsPass = !IsPass;
    sufix = IsPass
        ? Icon(Icons.visibility_off_outlined)
        : Icon(Icons.visibility_outlined);
    emit(SocialRegisterChangPassState());
  }
}
