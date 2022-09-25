import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/modules/Login_screen/cubit.dart';
import 'package:social_app/modules/Login_screen/states.dart';
import 'package:social_app/modules/layouts/home_layout.dart';
import 'package:social_app/modules/register_screen/register_screeen.dart';
import 'package:social_app/shared/cache_helper.dart';
import 'package:social_app/shared/components.dart';

var emailController = TextEditingController();
var passwordcontroller = TextEditingController();
var formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorStates) {
            showToast(
                msg: state.error,
                state: ToastStates.ERROR,
                gravity: ToastGravity.BOTTOM);
          }
          if (state is SocialLoginSuccessStates) {
            cacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, HomeLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          "Login now to browse our hot offers",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormFeild(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (index) {
                              if (index!.isEmpty)
                                return 'email must not be empty ';
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFeild(
                            controller: passwordcontroller,
                            type: TextInputType.text,
                            ispassword:
                                SocialLoginCubit.get(context).isPassword,
                            suffix: SocialLoginCubit.get(context).suffix,
                            onTap: () {
                              SocialLoginCubit.get(context).ChangeVisibility();
                            },
                            validate: (index) {
                              if (index!.isEmpty)
                                return 'password must not be empty ';

                              return null;
                            },
                            label: 'password',
                            prefix: Icons.lock_clock_outlined),
                        SizedBox(
                          height: 15.0,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! SocialloadingStates,
                            builder: (context) => defaultButton(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordcontroller.text);
                                  }
                                },
                                text: 'Login',
                                isUpper: true),
                            fallback: (context) => CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("don\'t have an account ?"),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: Text("Regiseter now")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
