import 'package:flutter/material.dart';
import 'package:mastermold/core/color/appcolors.dart';

class customtableclientitem extends StatelessWidget {
  final String clientname;
  final String phone;
  final String fac;

  Widget delet;
  Widget edit;
  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: Appcolors.maincolor);

  customtableclientitem(
      {super.key,
      required this.clientname,
      required this.phone,
      required this.fac,
      required this.edit,
      required this.delet});
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
              clientname,
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
                fac,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 2,
            child: delet,
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
