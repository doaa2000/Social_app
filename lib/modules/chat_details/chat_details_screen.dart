import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/state.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/styles/color.dart';
import 'package:social_app/styles/icon_broken.dart';

class ChatDetailScreen extends StatelessWidget {
  late userModel model;
  ChatDetailScreen(this.model);
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialAppCubit.get(context).getMessages(receiverId: model.uId as String);
      return BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(model.image as String),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    model.name as String,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: SocialAppCubit.get(context).messages.length > 0,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                SocialAppCubit.get(context).messages[index];
                            if (SocialAppCubit.get(context).usermodel!.uId ==
                                message.senderId)
                              return buildMyMessage(message);
                            return buildMessage(message);
                          },
                          separatorBuilder: (context, state) => SizedBox(
                                height: 15.0,
                              ),
                          itemCount:
                              SocialAppCubit.get(context).messages.length),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '   type your message here ...',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 15.0,
                                    ),
                              ),
                            ),
                          ),
                          Container(
                              height: 50.0,
                              color: defaultColor,
                              child: MaterialButton(
                                minWidth: 1.0,
                                onPressed: () {
                                  SocialAppCubit.get(context).sendMessage(
                                      receiverId: model.uId as String,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                },
                                child: Icon(
                                  IconBroken.Send,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      );
    });
  }
}

Widget buildMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          child: Text(model.text as String)),
    );

Widget buildMyMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          child: Text(model.text as String)),
    );
