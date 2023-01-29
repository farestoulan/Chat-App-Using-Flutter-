import 'package:bloc/bloc.dart';
import 'package:chat_app/models/social_user_model.dart';
import 'package:chat_app/modules/register_screen/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  void userCreate(
      {required String name,
      required String email,
      required String phone,
      required String uId}) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write you bio ....',
      cover:
          'https://as1.ftcdn.net/v2/jpg/01/10/84/94/1000_F_110849453_sh5KI91ge8YY59XhzEC6VrHekMkViSLQ.jpg',
      image:
          'https://as1.ftcdn.net/v2/jpg/01/10/84/94/1000_F_110849453_sh5KI91ge8YY59XhzEC6VrHekMkViSLQ.jpg',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      CreateUserErrorState(error.toString());
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordVisibilityState());
  }
}
