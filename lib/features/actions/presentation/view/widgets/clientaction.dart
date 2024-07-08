import 'package:flutter/material.dart';
import 'package:mastermold/core/color/appcolors.dart';

class customtableclientactionitem extends StatelessWidget {
  final String date;
  final String bayan;
  String? maintenance;
  String? payment;

  Widget check;
  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: Appcolors.maincolor);

  customtableclientactionitem(
      {super.key,
      required this.date,
      required this.bayan,
      required this.check,
      this.maintenance,
      this.payment});

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height / 19),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              date,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                bayan,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                payment == null ? "" : payment!,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                maintenance == null ? "" : maintenance!,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 2,
            child: check,
          ),
        ],
      ),
    );
  }
}
