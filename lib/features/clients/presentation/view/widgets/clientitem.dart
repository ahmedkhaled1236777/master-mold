import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mastermold/core/color/appcolors.dart';

class customtableclientitem extends StatelessWidget {
  final String clientname;
  final String phone;
  final String fac;

  Widget delet;
  Widget edit;
  TextStyle textStyle =
      TextStyle(fontSize: 11.4.sp, color: Appcolors.maincolor);

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
              style: MediaQuery.sizeOf(context).width < 600
                  ? textStyle
                  : TextStyle(fontSize: 15, color: Appcolors.maincolor),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
              flex: 3,
              child: Text(
                phone,
                style: MediaQuery.sizeOf(context).width < 600
                    ? textStyle
                    : TextStyle(fontSize: 15, color: Appcolors.maincolor),
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                fac,
                style: MediaQuery.sizeOf(context).width < 600
                    ? textStyle
                    : TextStyle(fontSize: 15, color: Appcolors.maincolor),
                textAlign: TextAlign.center,
              )),
          Expanded(
            flex: 2,
            child: edit,
          ),
          Expanded(
            flex: 2,
            child: delet,
          ),
        ],
      ),
    );
  }
}
