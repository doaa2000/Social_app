import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/state.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/styles/color.dart';
import 'package:social_app/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialAppCubit.get(context).posts.length > 0,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 20.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/young-redhead-half-turned-woman-toothy-smiling_23-2148183276.jpg?w=900&t=st=1649086550~exp=1649087150~hmac=6eb507760e7a9cef75b9894db0734bf30dd94d451fde4a364d3d455697b9456f'),
                          fit: BoxFit.cover,
                          height: 200.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate with friends',
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(context,
                        SocialAppCubit.get(context).posts[index], index),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 8.0,
                        ),
                    itemCount: SocialAppCubit.get(context).posts.length),
              ],
            ),
          ),
          fallback: (BuildContext context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildPostItem(context, postModel model, index) => Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${model.name}'),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 15.0,
                          )
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
              child: Text('${model.text}'),
            ),
            // Container(
            //   width: double.infinity,
            //   child: Wrap(
            //     children: [
            //       Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 5.0,
            //           ),
            //           child: Container(
            //             height: 30.0,
            //             child: MaterialButton(
            //                 minWidth: 1.0,
            //                 padding: EdgeInsets.zero,
            //                 onPressed: () {},
            //                 child: Text(
            //                   '#Software',
            //                   style:
            //                       Theme.of(context).textTheme.caption!.copyWith(
            //                             color: defaultColor,
            //                           ),
            //                 )),
            //           )),
            //       Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 5.0,
            //           ),
            //           child: Container(
            //             height: 30.0,
            //             child: MaterialButton(
            //                 minWidth: 1.0,
            //                 padding: EdgeInsets.zero,
            //                 onPressed: () {},
            //                 child: Text(
            //                   '#Flutter',
            //                   style:
            //                       Theme.of(context).textTheme.caption!.copyWith(
            //                             color: defaultColor,
            //                           ),
            //                 )),
            //           )),
            //     ],
            //   ),
            // ),
            // Container(
            //   height: 140.0,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(4.0),
            //       image: DecorationImage(
            //         image: NetworkImage(
            //             'https://img.freepik.com/free-photo/young-redhead-half-turned-woman-toothy-smiling_23-2148183276.jpg?w=900&t=st=1649086550~exp=1649087150~hmac=6eb507760e7a9cef75b9894db0734bf30dd94d451fde4a364d3d455697b9456f'),
            //         fit: BoxFit.cover,
            //       )),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                              size: 16.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('${SocialAppCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                              size: 16.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('0 Comment',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16.0,
                          backgroundImage: NetworkImage(
                              '${SocialAppCubit.get(context).usermodel?.image}'),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'write a comment...',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('Like', style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                  onTap: () {
                    SocialAppCubit.get(context)
                        .likePost(SocialAppCubit.get(context).postsId[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
