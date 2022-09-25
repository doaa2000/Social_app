import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/state.dart';

import 'package:social_app/modules/Login_screen/login_screen.dart';
import 'package:social_app/modules/register_screen/register_screeen.dart';
import 'package:social_app/shared/cache_helper.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/styles/themes/themes.dart';

import 'modules/layouts/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(
        msg: 'on message',
        state: ToastStates.SUCCESS,
        gravity: ToastGravity.BOTTOM);
  });

  await cacheHelper.init();
  Widget widget;
  uId = cacheHelper.getData(key: 'uId');

  if (uId != null)
    widget = HomeLayout();
  else
    widget = LoginScreen();

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  late final Widget startWidget;
  MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => SocialAppCubit()
              ..getUserData()
              ..getPosts(),
          ),
        ],
        child: BlocConsumer<SocialAppCubit, SocialAppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Dem12345678o',
                theme: lightTheme,
                home: startWidget,
              );
            }));
  }
}
