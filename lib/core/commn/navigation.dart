import 'package:flutter/material.dart';
import 'package:get/get.dart';

navigateto({required Widget navigationscreen, required BuildContext context}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    return navigationscreen;
  }));
}

navigateandfinish(
    {required Widget navigationscreen, required BuildContext context}) {
  /* Get.off(navigationscreen,
      transition: Transition.rightToLeft,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut);*/
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
    return navigationscreen;
  }));
}
