import 'package:flutter/material.dart';
import 'package:mastermold/core/color/appcolors.dart';

class customtableemployeeitem extends StatelessWidget {
  final String employeename;
  final String phone;
  final String status;

  Widget edit;
  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: Appcolors.maincolor);

  customtableemployeeitem({
    super.key,
    required this.employeename,
    required this.phone,
    required this.status,
    required this.edit,
  });
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
              employeename,
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
                phone,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                status,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 2,
            child: edit,
          ),
        ],
      ),
    );
  }
}
