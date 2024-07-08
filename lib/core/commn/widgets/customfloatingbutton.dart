import 'package:flutter/material.dart';
import 'package:mastermold/core/color/appcolors.dart';

class customfloatingbutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Appcolors.primarycolor,
      onPressed: () {},
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
