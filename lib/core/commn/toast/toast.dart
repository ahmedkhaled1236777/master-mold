import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Toaststate { succes, error, other }

showtoast(
    {required String message,
    required Toaststate toaststate,
    required BuildContext context}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: toaststate == Toaststate.error
        ? Colors.red
        : toaststate == Toaststate.succes
            ? Colors.green
            : Colors.grey,
    margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        bottom: MediaQuery.of(context).size.height * 0.1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content: Center(child: Text(message)),
  )); /*Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toaststate == Toaststate.error
          ? Colors.red
          : toaststate == Toaststate.succes
              ? Colors.green
              : Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);*/
}
