// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Appstyles {
  static TextStyle textStyle13w = TextStyle(
    color: Colors.white,
    fontFamily: "cairo",
  );
  static TextStyle textStyle13am = TextStyle(
    color: Colors.amber,
    fontFamily: "cairo",
  );
  static TextStyle textStyle13wdd = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w300,
      fontSize: 3.3.sp.clamp(0, 3.3.sp));
  static TextStyle textStyle13wd = TextStyle(
      color: Colors.white, fontWeight: FontWeight.w300, fontSize: 3.5.sp);
  static TextStyle textStyle14wm =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14);
  static TextStyle textStyle14wt = TextStyle(
      color: Colors.white, fontWeight: FontWeight.w300, fontSize: 10.sp);
  static const TextStyle textStyle12 =
      TextStyle(fontSize: 13, color: Colors.black38, fontFamily: "Alexandria");
  static const TextStyle textStyle12b = const TextStyle(
      fontSize: 12.5, color: Colors.black, fontFamily: "Alexandria");
  static const TextStyle textStyle15 =
      TextStyle(fontSize: 15, color: Colors.white, fontFamily: "Alexandria");
  static gettabletextstyle({required BuildContext context}) {
    return MediaQuery.of(context).size.width > 950
        ? Appstyles.textStyle12b.copyWith(fontSize: 3.3.sp)
        : MediaQuery.of(context).size.width > 600
            ? Appstyles.textStyle12b.copyWith(fontSize: 5.5.sp)
            : Appstyles.textStyle12b.copyWith(fontSize: 9.8.sp);
  }

  static getheadertextstyle({required BuildContext context}) {
    return MediaQuery.of(context).size.width > 950
        ? Appstyles.textStyle13wdd
        : MediaQuery.of(context).size.width < 950 &&
                MediaQuery.of(context).size.width > 600
            ? Appstyles.textStyle13wd.copyWith(fontSize: 5.sp)
            : Appstyles.textStyle13wd.copyWith(fontSize: 10.sp);
  }
}
