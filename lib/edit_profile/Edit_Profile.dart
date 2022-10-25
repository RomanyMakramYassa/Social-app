import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/coponanet/coponanet.dart';
import '../shared/styles/iconbroken.dart';
import '../social_app/social_cubit.dart';
import '../social_app/social_state.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userModel = SocialCubit.get(context).model;
    var Profileimage = SocialCubit.get(context).ProfileImage;
    var Coverimage = SocialCubit.get(context).coverImage;
    var namecontroler = TextEditingController();
    var biocontroler = TextEditingController();
    var phonecontroler = TextEditingController();
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        //  namecontroler.text = userModel!.name!;
        //    biocontroler.text = userModel!.bio!;
        //      phonecontroler.text = userModel!.phone!;
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2),
              ),
              title: Text('Edit Profile'),
              actions: [
                TextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                          name: //userModel!.name!,
                              namecontroler.text,
                          phone: phonecontroler.text,
                          //   userModel.phone!, //
                          bio: biocontroler.text
                          //userModel.bio!,
                          //,
                          );
                    },
                    child: Text('Update')),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8),
                // child: SingleChildScrollView()
                child: Column(
                  children: [
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: Coverimage == null
                                            ? NetworkImage(
                                                '${userModel?.cover}',
                                              )
                                            : FileImage(Coverimage)
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getCovereimage();
                                    },
                                    icon: CircleAvatar(
                                      radius: 20,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 16,
                                      ),
                                    ))
                              ],
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 65,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: Profileimage == null
                                      ? NetworkImage('${userModel?.image}')
                                      : FileImage(Profileimage)
                                          as ImageProvider,
                                ),
                              ),
                              CircleAvatar(
                                child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .getprofileimage();
                                    },
                                    icon: Icon(IconBroken.Camera)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (SocialCubit.get(context).coverImage != null ||
                        SocialCubit.get(context).ProfileImage != null)
                      Row(
                        children: [
                          if (SocialCubit.get(context).coverImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defultbouton(
                                      function: () {
                                        SocialCubit.get(context)
                                            .uploadCoverimage(
                                                name: namecontroler.text,
                                                phone: phonecontroler.text,
                                                bio: biocontroler.text);
                                        print('uplode cover');
                                      },
                                      text: 'uplode cover'),
                                  if (state is SocialuserupdateLoadingState)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (state is SocialuserupdateLoadingState)
                                    LinearProgressIndicator()
                                ],
                              ),
                            ),
                          SizedBox(
                            width: 10,
                          ),
                          if (SocialCubit.get(context).ProfileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defultbouton(
                                      function: () {
                                        print('hhhh');
                                        SocialCubit.get(context)
                                            .uplaodprofileimage(
                                                name: namecontroler.text,
                                                phone: phonecontroler.text,
                                                bio: biocontroler.text);
                                      },
                                      text: 'uplode profile'),
                                  if (state is SocialuserupdateLoadingState)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (state is SocialuserupdateLoadingState)
                                    LinearProgressIndicator()
                                ],
                              ),
                            )
                        ],
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    defultTxtform(
                        controller: namecontroler,
                        Texttypein: TextInputType.name,
                        valedate: (String valuo) {
                          if (valuo.isEmpty) {
                            return 'name must not empty';
                          }
                        },
                        label: 'name',
                        icn: IconBroken.User),
                    SizedBox(
                      height: 10,
                    ),
                    defultTxtform(
                        controller: biocontroler,
                        Texttypein: TextInputType.text,
                        valedate: (String valuo) {
                          if (valuo.isEmpty) {
                            return 'bio must not empty';
                          }
                        },
                        label: 'Bio',
                        icn: IconBroken.Info_Circle),
                    SizedBox(
                      height: 10,
                    ),
                    defultTxtform(
                        controller: phonecontroler,
                        Texttypein: TextInputType.phone,
                        valedate: (String valuo) {
                          if (valuo.isEmpty) {
                            return 'phone must not empty';
                          }
                        },
                        label: 'Phone',
                        icn: IconBroken.Call)
                  ],
                ),
              ),
            ));
      },
    );
  }
}
