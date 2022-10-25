import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../SocialUserModel/UserModel.dart';
import '../SocialUserModel/messagemodel.dart';
import '../shared/styles/iconbroken.dart';
import '../social_app/social_cubit.dart';
import '../social_app/social_state.dart';

class ChatDetails extends StatelessWidget {
  SocialUserModel? usermodel;

  ChatDetails({this.usermodel});
  var messagecontroler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getmessage(receiverId: usermodel!.uId!);
      return BlocConsumer<SocialCubit, SocialState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://t3.ftcdn.net/jpg/03/16/82/06/240_F_316820624_1R45ZpURWLJOv0aQZxTvGkEpXS3yeWcV.jpg'
                          //    '${usermodel!.image}'
                          ),
                      radius: 20,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('romany makram'
                        // '${usermodel!.name}'
                        '')
                  ],
                ),
              ),
              body: ConditionalBuilder(
                  condition: SocialCubit.get(context).message.length > 0,
                  builder: (context) => Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var message =
                                        SocialCubit.get(context).message[index];
                                    if (SocialCubit.get(context).model!.uId ==
                                        message.senderId)
                                      return buildmyMessage(message);

                                    return buildmessage(message);
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 15,
                                      ),
                                  itemCount:
                                      SocialCubit.get(context).message.length),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.all(6),
                                    child: TextFormField(
                                        controller: messagecontroler,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'write your massage')),
                                  )),
                                  Container(
                                    color: Colors.blue,
                                    height: 60,
                                    child: MaterialButton(
                                      minWidth: 1,
                                      onPressed: () {
                                        SocialCubit.get(context).SendMessage(
                                            text: messagecontroler.text,
                                            receiverId: usermodel!.uId!,
                                            datetime:
                                                DateTime.now().toString());
                                      },
                                      child: Icon(
                                        IconBroken.Send,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                      )));
        },
        listener: (context, state) {},
      );
    });
  }

  Widget buildmessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              )),
          child: Text(
            model.text!,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
  Widget buildmyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              )),
          child: Text(model.text!, style: TextStyle(fontSize: 16)),
        ),
      );
}
