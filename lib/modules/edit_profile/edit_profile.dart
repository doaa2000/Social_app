import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/state.dart';
import 'package:social_app/modules/Login_screen/login_screen.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var usermodel = SocialAppCubit.get(context).usermodel;
        var profileImage = SocialAppCubit.get(context).profileImage;

        nameController.text = usermodel!.name as String;
        bioController.text = usermodel.bio as String;
        phoneController.text = usermodel.phone as String;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit profile',
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2),
              color: Colors.black,
            ),
            titleSpacing: 5.0,
            actions: [
              TextButton(
                  onPressed: () {
                    SocialAppCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  child: Text('UPDATE')),
              SizedBox(
                width: 5.0,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocilaUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(height: 10.0),
                  Container(
                    height: 200.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage('${usermodel.cover}'),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20.0,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        IconBroken.Camera,
                                        size: 20.0,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${usermodel.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            CircleAvatar(
                              radius: 20.0,
                              child: IconButton(
                                  onPressed: () {
                                    SocialAppCubit.get(context).getImage();
                                  },
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 20.0,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormFeild(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormFeild(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'bio must not be empty';
                        }
                        return null;
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormFeild(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'phone number must not be empty';
                        }
                        return null;
                      },
                      label: 'phone',
                      prefix: IconBroken.Call),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
