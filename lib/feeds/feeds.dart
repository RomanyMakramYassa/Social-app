import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../SocialUserModel/postmodel.dart';
import '../shared/styles/iconbroken.dart';
import '../social_app/social_cubit.dart';
import '../social_app/social_state.dart';

var comentcontrolar = TextEditingController();

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).GetUser();
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialCubit.get(context).posts.length >
                0, //  && SocialCubit.get(context).model != null,
            builder: (context) => SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        elevation: 10,
                        margin: EdgeInsets.all(10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image(
                                fit: BoxFit.cover,
                                height: 200,
                                image: NetworkImage(
                                    'https://t3.ftcdn.net/jpg/03/16/82/06/240_F_316820624_1R45ZpURWLJOv0aQZxTvGkEpXS3yeWcV.jpg')),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Comunicate with friend',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                        itemBuilder: (context, index) => buildPostItem(
                            SocialCubit.get(context).posts[index],
                            context,
                            index),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: SocialCubit.get(context).posts.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      )
                    ],
                  ),
                ),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
        elevation: 8.00,
        margin: EdgeInsets.symmetric(horizontal: 10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('${model.image}')),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${model.name}',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 16,
                              )
                            ],
                          ),
                          Text(
                            '${model.datetime}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    height: 1,
                                    fontSize: 16,
                                    color: Colors.grey[300]),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                  ],
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                ),
                Text(
                  '${model.text}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                // if(model.postimage!='')
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 5),
                  child: Container(
                    width: double.infinity,
                    child: Wrap(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(end: 3),
                          child: Container(
                            height: 25,
                            child: MaterialButton(
                              onPressed: () {},
                              minWidth: 1,
                              padding: EdgeInsets.zero,
                              child: Text('#Software',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.blue)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(end: 3),
                          child: Container(
                            height: 25,
                            child: MaterialButton(
                              onPressed: () {},
                              minWidth: 1,
                              padding: EdgeInsets.zero,
                              child: Text('#Flutter',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.blue)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (model.postimage != '')
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage('${model.postimage}'),
                          fit: BoxFit.cover,
                        )),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Icon(
                                      IconBroken.Heart,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                        '${SocialCubit.get(context).likes[index]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                  ],
                                ),
                              ))),
                      Expanded(
                          child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      IconBroken.Message,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      '${SocialCubit.get(context).comments[index]}  comment',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                  'https://t3.ftcdn.net/jpg/02/99/04/20/240_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg'
                                  //    '${SocialCubit.get(context).model!.image}'
                                  )),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Write a comment...'),
                          /*
                          TextFormField(
                            controller: comentcontrolar,

                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(
                                    hintText: '.Write a comment.'),
                          ),*/
                        ],
                      ),
                      onTap: () {
                        SocialCubit.get(context).comentpost(
                            SocialCubit.get(context).postid[index], 'hhhhh');
                      },
                    )),
                    InkWell(
                        onTap: () {
                          SocialCubit.get(context)
                              .likepost(SocialCubit.get(context).postid[index]);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                color: Colors.red,
                                size: 16,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Like',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            )),
      );
}
