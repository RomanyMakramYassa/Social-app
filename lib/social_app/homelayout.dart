import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/social_app/social_cubit.dart';
import 'package:socialapp/social_app/social_state.dart';

import '../../shared/coponanet/coponanet.dart';
import '../newpost/newpost.dart';
import '../shared/styles/iconbroken.dart';

class Social_Layout extends StatelessWidget {
  const Social_Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is SocialAddNewPostState) Navigateto(context, NewPost());
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.Currentindex,
            onTap: (index) {
              cubit.changeBottonnav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Add'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.User), label: 'users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
          ),
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Text(
              cubit.Title[cubit.Currentindex],
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.SocialScreen[cubit.Currentindex],
          /*
              body: ConditionalBuilder(
                  condition: true, //SocialCubit.get(context).model != null,
                  builder: (context) {
                    var model =
                        FirebaseAuth.instance.currentUser!.emailVerified;
                    print(model);
                    return Column(
                      children: [
                        if (!model)
                          Container(
                              color: Colors.amber,
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Send Email varivication'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.currentUser!
                                            .sendEmailVerification()
                                            .then((value) {
                                          Showtost(
                                              text: 'check your email',
                                              state: teaststates.SUCCESS);
                                        }).catchError((onError) {
                                          Showtost(
                                              text:
                                                  'check your email and resend',
                                              state: teaststates.ERROR);
                                        });
                                      },
                                      child: Text('send')),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10))
                      ],
                    );
                  },
                  fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                      ))
              */
        );
      },
    );
  }
}
