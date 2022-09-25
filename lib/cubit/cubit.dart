import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:social_app/cubit/state.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/register_screen/cubit/states.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/user_screen.dart';
import 'package:social_app/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppInitialState());

  static SocialAppCubit get(context) => BlocProvider.of(context);
  userModel? usermodel;
  void getUserData() {
    emit(SocialAppGetUserLoadingState());
    FirebaseFirestore.instance.collection('da').doc(uId).get().then((value) {
      usermodel = userModel.fromJson(value.data() as Map<String, dynamic>);
      print(value.data());
      emit(SocialAppGetUserSuccessState());
    }).catchError((error) {
      emit(SocialAppGetUserErrorState());
      print(error.toString());
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocilaProfileImagePickedErrorState());
    } else {
      print('No image selected.');
      emit(SocilaProfileImagePickedErrorState());
    }
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'post',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int index) {
    if (index == 1) getAllUsers();
    if (index == 2)
      emit(SocialAppNewPostState());
    else {
      currentIndex = index;
      emit(SocialAppChangeBottomNavState());
    }
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? email,
  }) {
    emit(SocilaUserUpdateLoadingState());
    userModel model = userModel(
      email: email,
      name: name,
      phone: phone,
      uId: usermodel!.uId,
      bio: usermodel!.bio,
      image: usermodel!.image,
      cover: usermodel!.cover,
    );

    FirebaseFirestore.instance
        .collection('da')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {});
  }

  void createPost({
    required String dateTime,
    required String text,
  }) {
    //emit(SocilaUserUpdateLoadingState());
    postModel model = postModel(
      dateTime: dateTime,
      name: usermodel!.name,
      text: text,
      uId: usermodel!.uId,
      image: usermodel!.image,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocilaCreateUserSuccessState());
      posts = [];
      likes = [];
      getPosts();
    }).catchError((error) {
      emit(SocilaCreateUserErrorState());
    });
  }

  List<postModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<userModel> users = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(postModel.fromJson(element.data()));
          emit(SocialAppGetPostSuccessState());
        });
      });
    }).catchError((error) {
      emit(SocialAppGetPostErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(usermodel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialAppLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState());
    });
  }

  void getAllUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('da').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != usermodel!.uId)
            users.add(userModel.fromJson(element.data()));
          emit(getAllUsersSuccessState());
        });
      }).catchError((error) {
        emit(getAllUsersErrorState());
      });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        dateTime: dateTime,
        receiverId: receiverId,
        senderId: usermodel!.uId,
        text: text);
//set my chat
    FirebaseFirestore.instance
        .collection('da')
        .doc(usermodel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
    // set receiver chat
    FirebaseFirestore.instance
        .collection('da')
        .doc(receiverId)
        .collection('chats')
        .doc(usermodel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('da')
        .doc(usermodel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMseeageSuccessState());
    });
  }
  // File? profileImage;
  // var picker = ImagePicker();

  // Future getProfileImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);

  //   if (pickedFile != null) {
  //     profileImage = File(pickedFile.path);
  //     emit(SocilaProfileImagePickedSuccessState());
  //   } else {
  //     print('No image selected.');
  //     emit(SocilaProfileImagePickedErrorState());
  //   }
  // }
}
