import 'package:chat_app/layout/cubit/social_cubit.dart';
import 'package:chat_app/layout/cubit/social_states.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit , SocialStates>(
      listener: (context ,state){},
      builder: (context ,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'New Feed'
                  ,
            ),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).userModel != null ,
            builder: (context) {
              var model = SocialCubit.get(context).userModel;
              return Column(
                children: [

                  if( !FirebaseAuth.instance.currentUser!.emailVerified)
                  Container(
                    color: Colors.amber.withOpacity(.6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Row(
                        children:  [
                          Icon(Icons.info_outline),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Text(
                                'Please verify your email'
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 20.0,
                          ),
                          defaultTextButton(function:  (){
                            FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
                              showToast(msg: 'check your mail',
                                  state: ToastStates.ERROR,
                              );
                            }).catchError((error){
                              
                            });
                          },
                            text: 'Send ',

                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            fallback:(context) => Center(child: CircularProgressIndicator()),

          ),

        );
      },

    );
  }
}
