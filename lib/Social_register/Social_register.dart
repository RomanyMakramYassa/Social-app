import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/coponanet/coponanet.dart';
import '../social_app/homelayout.dart';
import 'Social_register_cubit/cubit.dart';
import 'Social_register_cubit/stats.dart';

var frmKey = GlobalKey<FormState>();
var emailcontroler = TextEditingController();
var passcontrolar = TextEditingController();
var namecontroler = TextEditingController();
var phonecontrolar = TextEditingController();

class SocialregisterScreen extends StatelessWidget {
  const SocialregisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStat>(
          listener: (context, state) {
        if (state is SocialCreateRegisterSucessState) {
          Navigatefinish(context, Social_Layout());
        }
        /*
        if (state is RegisterSucessState) {
          if (state.Registermode.status!) {
            print('hna register succiss');
            print(state.Registermode.data);
            print(state.Registermode.status);
            Fluttertoast.showToast(
                msg: state.Registermode.massege!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);

            print(state.Registermode.data!.token);
            // Navigatefinish(context, HLogin());
            CachHelper.savedata(
                    key: 'token', val: state.Registermode.data!.token)
                .then((value) {
              Navigatefinish(context, HLogin());
            });
          } else {
            print('hna register eroror');
            print(state.Registermode.massege);
            Showtost(
                text: state.Registermode.massege!, state: teaststates.ERROR);
          }
        }*/
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(20.00),
                  child: Form(
                    key: frmKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontSize: 50.00),
                        ),
                        SizedBox(
                          height: 2.00,
                        ),
                        Text(
                          'Register Now ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 4.00,
                        ),
                        TextFormField(
                          controller: namecontroler,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefix: Icon(Icons.person),
                            label: Text('User Name'),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'add User name';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.00,
                        ),
                        TextFormField(
                          controller: emailcontroler,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefix: Icon(Icons.mail),
                            label: Text('email'),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'must add email';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.00,
                        ),
                        TextFormField(
                          controller: passcontrolar,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: SocialRegisterCubit.get(context).IsPass,
                          onFieldSubmitted: (valu) {
                            if (frmKey.currentState!.validate()) {
                              SocialRegisterCubit.get(context).RegisterLogin(
                                  email: emailcontroler.text,
                                  password: passcontrolar.text,
                                  phone: phonecontrolar.text,
                                  name: namecontroler.text);
                            }
                            ;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefix: Icon(Icons.lock),
                            suffix: IconButton(
                              icon: SocialRegisterCubit.get(context).sufix,
                              onPressed: () {
                                SocialRegisterCubit.get(context).changrsufix();
                              },
                            ),
                            label: Text('Password'),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Password is to short ';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.00,
                        ),
                        TextFormField(
                          controller: phonecontrolar,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefix: Icon(Icons.phone),
                            label: Text('Phone'),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'must add phone number';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.00,
                        ),
                        ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            builder: (context) => Container(
                                  width: double.infinity,
                                  color: Colors.blue,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (frmKey.currentState!.validate()) {
                                        SocialRegisterCubit.get(context)
                                            .RegisterLogin(
                                                email: emailcontroler.text,
                                                password: passcontrolar.text,
                                                name: namecontroler.text,
                                                phone: phonecontrolar.text);
                                        Navigatefinish(
                                            context, Social_Layout());
                                      }
                                    },
                                    child: Text(
                                      'Register'.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                            fallback: (context) => Center(
                                  child: CircularProgressIndicator(),
                                )),
                        /*    ConditionalBuilder(
                                condition: true, //states is! LoginLoadingState,
                                builder: (context) => defultbouton(
                                    text: 'Login',
                                    function: () {
                                      print('ghgh');

                                      if (frmKey.currentState!.validate()) {
                                        LoginCubit.get(context).UserLogin(
                                            email: emailcontroler.text,
                                            Password: passcontrolar.text);
                                      }
                                    }),
                                fallback: (context) => Center(
                                      child: CircularProgressIndicator(),
                                    )),*/
                      ],
                    ),
                  )),
            ),
          ),
        );
      }),
    );
  }
}
