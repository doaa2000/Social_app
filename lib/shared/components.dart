import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/styles/icon_broken.dart';

Function validate = () {};
Function onTap = () {};

Widget defaultButton({
  required onTap,
  required String text,
  bool isUpper = false,
}) {
  return Material(
    borderRadius: BorderRadius.circular(50.0),
    color: Colors.blue,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: Text(
          isUpper == true ? text.toUpperCase() : text.toLowerCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

AppBar defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      title: Text(title as String),
      leading: IconButton(
        icon: Icon(
          IconBroken.Arrow___Left,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: actions,
    );

Widget defaultFormFeild({
  required TextEditingController controller,
  required TextInputType type,
  required validate,
  required String label,
  required IconData prefix,
  onTap,
  bool ispassword = false,
  IconData? suffix,
  TextEditingController? Controller,
}) =>
    Material(
      shadowColor: Colors.blue,
      child: TextFormField(
        controller: controller,
        obscureText: ispassword,
        keyboardType: type,
        onTap: onTap,
        validator: validate,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null ? Icon(suffix) : null,
        ),
      ),
    );

Widget buildTaskItem(Map model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            child: Text("${model['title']}"),
            radius: 40.0,
            backgroundColor: Colors.deepPurple,
          ),
          SizedBox(
            width: 15.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${model['time']}",
                style: TextStyle(fontSize: 10.0),
              ),
              Text(
                "${model['date']}",
                style: TextStyle(fontSize: 10.0, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget myDivider() {
  return Container(
    height: 1.0,
    width: double.infinity,
    color: Colors.grey[300],
  );
}

// toast

void showToast({
  required String msg,
  required ToastStates state,
  required ToastGravity gravity,
}) =>
    {
      Fluttertoast.showToast(
        backgroundColor: chooseToastColor(state),
        gravity: gravity,
        msg: msg,
      ),
    };

enum ToastStates { WARNING, ERROR, SUCCESS }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
