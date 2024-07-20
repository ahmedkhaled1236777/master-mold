import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/navigation.dart';
import 'package:mastermold/core/commn/sharedpref/cashhelper.dart';
import 'package:mastermold/features/auth/presentation/view/login.dart';
import 'package:mastermold/features/home/presentation/view/home.dart';

class splash extends StatefulWidget {
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  bool isFirst = true;

  bool issecond = false;

  bool vis = false;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          isFirst = false;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() {
          issecond = true;
        });
      }
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (isFirst == false && issecond == true) {
        navigateandfinish(
            context: context,
            navigationscreen:
                cashhelper.getdata(key: "token") != null ? home() : Login());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolors.maincolor,
        body: AnimatedRotation(
          duration: const Duration(milliseconds: 600),
          turns: issecond ? .25 : 0,
          child: AnimatedAlign(
            alignment: isFirst ? Alignment.topCenter : Alignment.center,
            duration: const Duration(milliseconds: 400),
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 300),
              turns: isFirst ? 0 : -1.25,
              child: SizedBox(
                width: 296,
                height: 282,
                child: Image.asset("assets/images/master.jpg"),
              ),
            ),
          ),
        ));
  }
}
