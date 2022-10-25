import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../SocialUserModel/UserModel.dart';
import '../chat_details/chat_details.dart';
import '../shared/coponanet/coponanet.dart';
import '../social_app/social_cubit.dart';
import '../social_app/social_state.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: SocialCubit.get(context).users.length > 0,
              builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildchatitem(
                      context, SocialCubit.get(context).users[index]),
                  separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black,
                      ),
                  itemCount: SocialCubit.get(context).users.length),
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }

  Widget buildchatitem(context, SocialUserModel model) => InkWell(
        onTap: () {
          Navigateto(
              context,
              ChatDetails(
                usermodel: model,
              ));
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 25, backgroundImage: NetworkImage('${model.image}')),
              SizedBox(
                width: 15,
              ),
              Text(
                '${model.name}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      );
}
