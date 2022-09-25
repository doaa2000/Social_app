import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/state.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(
                context, SocialAppCubit.get(context).users[index]),
            separatorBuilder: (context, index) => Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey[200],
                ),
            itemCount: SocialAppCubit.get(context).users.length);
      },
    );
  }
}

Widget buildChatItem(context, userModel model) => InkWell(
      onTap: () {
        navigateTo(context, ChatDetailScreen(model));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                '${model.image}',
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              '${model.name}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
