import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:socialapp/social_login/Social_logen_cubit/stats.dart';

class SocialLoginCubit extends Cubit<SocialLoginStat> {
  SocialLoginCubit() : super(SocialLoginIntialState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void UserLogin({required String email, required String password}) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('sucess _cubit login ');
      print(value.user!.email);

      emit(SocialLoginSucessState(value.user!.uid));
    }).catchError((onError) {
      print('eroror_cubit login');
      print(onError.toString());
      emit(SocialLoginerorState(onError.toString()));
    });
  }

  Icon sufix = Icon(Icons.visibility_outlined);
  bool IsPass = true;
  void changrsufix() {
    IsPass = !IsPass;
    sufix = IsPass
        ? Icon(Icons.visibility_off_outlined)
        : Icon(Icons.visibility_outlined);
    emit(SocialLoginChangPassState());
  }
}
