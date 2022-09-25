import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/state.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create Post',
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
                    SocialAppCubit.get(context).createPost(
                      dateTime: DateTime.now().toString(),
                      text: textController.text,
                    );
                  },
                  child: Text('POST')),
              SizedBox(
                width: 5.0,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocilaCreateUserLoadingState)
                  LinearProgressIndicator(),
                if (state is SocilaCreateUserLoadingState)
                  SizedBox(
                    height: 5.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          '${SocialAppCubit.get(context).usermodel!.image}'),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text('${SocialAppCubit.get(context).usermodel!.name}'),
                          SizedBox(
                            width: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind ....',
                      hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 16.0,
                          ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('add photo'),
                            ],
                          )),
                    ),
                    Expanded(
                      child:
                          TextButton(onPressed: () {}, child: Text('# tags')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
