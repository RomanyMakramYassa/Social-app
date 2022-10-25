import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/coponanet/coponanet.dart';
import '../shared/styles/iconbroken.dart';
import '../social_app/social_cubit.dart';
import '../social_app/social_state.dart';

var textcontrolar = TextEditingController();

class NewPost extends StatelessWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2),
              ),
              title: Text('Create Post'),
              actions: [
                dTextBoton(
                    func: () {
                      var now = DateTime.now();
                      if (SocialCubit.get(context).PostImage == null) {
                        SocialCubit.get(context).CreatePost(
                            datetime: now.toString(), text: textcontrolar.text);
                      } else {
                        SocialCubit.get(context).uploadPostimage(
                            datetime: now.toString(), text: textcontrolar.text);
                      }
                    },
                    Ttxt: 'Post')
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  if (state is SocialCreatepostLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialCreatepostLoadingState)
                    SizedBox(
                      height: 10,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              'https://t3.ftcdn.net/jpg/02/67/28/70/240_F_267287089_EfjIf0FgT6AyPYjmKdQQIvjnbd7fgOMk.jpg')),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                        'Romany M Yassa',
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: textcontrolar,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'what in your mind ...'),
                  )),
                  if (SocialCubit.get(context).PostImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: FileImage(
                                    SocialCubit.get(context).PostImage!),
                                fit: BoxFit.cover,
                              )),
                        ),
                        IconButton(
                            onPressed: () {
                              SocialCubit.get(context).removePostimage();
                            },
                            icon: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.close,
                                size: 16,
                              ),
                            ))
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                SocialCubit.get(context).getPostimage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(IconBroken.Image),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text('add photo')
                                ],
                              ))),
                      Expanded(
                          child: TextButton(
                        onPressed: () {},
                        child: Text('# tags'),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
