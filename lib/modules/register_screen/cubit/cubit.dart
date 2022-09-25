import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register_screen/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(SocialRegisterloadingStates());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      UserCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
    }).catchError((error) {
      emit(SocialRegisterErrorStates(error.toString()));
    });
  }

  void UserCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    userModel model = userModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      bio: 'Write your bio...',
      image:
          'https://img.freepik.com/free-photo/portrait-handsome-young-boy_23-2148414490.jpg?w=740',
      cover:
          'https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984801.jpg?w=740',
    );
    FirebaseFirestore.instance
        .collection('da')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessStates());
    }).catchError((error) {
      emit(SocialCreateUserErrorStates(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void ChangeVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialAppChangePasswordVisibility());
  }
}
