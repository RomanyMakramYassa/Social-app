import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Social_register/Social_register.dart';
import '../shared/coponanet/coponanet.dart';
import '../shared/network/local/cachhelper.dart';
import '../social_app/homelayout.dart';
import 'Social_logen_cubit/cubit.dart';
import 'Social_logen_cubit/stats.dart';

var frmKey = GlobalKey<FormState>();
var emailcontroler = TextEditingController();
var passcontrolar = TextEditingController();

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStat>(
        listener: (context, state) {
          if (state is SocialLoginerorState) {
            Showtost(text: state.eror.toString(), state: teaststates.ERROR);
          }
          if (state is SocialLoginSucessState) {
            Showtost(text: 'ttttruuuooo', state: teaststates.SUCCESS);
            CachHelper.savedata(key: 'uid', val: state.uId).then((value) {
              Navigatefinish(context, Social_Layout());
            });
          }
        },
        builder: (context, state) {
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
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontSize: 50.00),
                          ),
                          SizedBox(
                            height: 2.00,
                          ),
                          Text(
                            'Login Now to comunicate',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 4.00,
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
                            obscureText: SocialLoginCubit.get(context).IsPass,
                            onFieldSubmitted: (valu) {
                              if (frmKey.currentState!.validate()) {
                                // SocialLoginCubit.get(context).UserLogin(
                                //   email: emailcontroler.text,
                                //  password: passcontrolar.text);
                              }
                              ;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefix: Icon(Icons.lock),
                              suffix: IconButton(
                                icon: SocialLoginCubit.get(context).sufix,
                                onPressed: () {
                                  SocialLoginCubit.get(context).changrsufix();
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
                          ConditionalBuilder(
                              condition: state is! SocialLoginLoadingState,
                              builder: (context) => Container(
                                    width: double.infinity,
                                    color: Colors.blue,
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (frmKey.currentState!.validate()) {
                                          SocialLoginCubit.get(context)
                                              .UserLogin(
                                                  email: emailcontroler.text,
                                                  password: passcontrolar.text);
                                          // Navigatefinish(context, HLogin());

                                        }
                                      },
                                      child: Text(
                                        'LOgin'.toUpperCase(),
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
                          SizedBox(
                            height: 10.00,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Dont Have An Account?'),
                              TextButton(
                                  onPressed: () {
                                    Navigateto(context, SocialregisterScreen());
                                  },
                                  child: Text('Regester')),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
