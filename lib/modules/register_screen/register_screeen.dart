import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Login_screen/cubit.dart';
import 'package:social_app/modules/Login_screen/login_screen.dart';
import 'package:social_app/modules/Login_screen/states.dart';
import 'package:social_app/modules/layouts/home_layout.dart';
import 'package:social_app/modules/register_screen/cubit/cubit.dart';
import 'package:social_app/modules/register_screen/cubit/states.dart';
import 'package:social_app/shared/components.dart';

class RegisterScreen extends StatelessWidget {
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SocialRegisterCubit(),
        child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
            listener: (context, state) {
          if (state is SocialCreateUserSuccessStates) {
            navigateAndFinish(context, HomeLayout());
          }
        }, builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormFeild(
                          controller: userNameController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty)
                              return 'username must not be empty ';
                          },
                          label: 'username',
                          prefix: Icons.person),
                      SizedBox(height: 15.0),
                      defaultFormFeild(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty)
                              return 'email must not be empty ';
                          },
                          label: 'email address',
                          prefix: Icons.email_outlined),
                      SizedBox(height: 15.0),
                      defaultFormFeild(
                          controller: passwordController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty)
                              return 'password must not be empty ';
                          },
                          label: 'password',
                          prefix: Icons.lock),
                      SizedBox(height: 15.0),
                      defaultFormFeild(
                          controller: phoneController,
                          type: TextInputType.number,
                          validate: (value) {
                            if (value.isEmpty)
                              return 'phone must not be empty ';
                          },
                          label: 'phone number',
                          prefix: Icons.phone_callback_outlined),
                      SizedBox(height: 20.0),
                      ConditionalBuilder(
                        condition: state is! SocialRegisterloadingStates,
                        builder: (context) => defaultButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                  name: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                            isUpper: true),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
