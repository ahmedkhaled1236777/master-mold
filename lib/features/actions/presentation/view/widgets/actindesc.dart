import 'package:flutter/material.dart';
import 'package:mastermold/core/color/appcolors.dart';

class actiondesc extends StatelessWidget {
  final String employeename;
  final String bayan;
  final String price;
  final String date;
  final String type;

  const actiondesc(
      {super.key,
      required this.employeename,
      required this.bayan,
      required this.price,
      required this.date,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Text(
            "تفاصيل الحركه",
            style: TextStyle(
                fontFamily: "cairo",
                fontSize: 12.5,
                color: Appcolors.maincolor),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Appcolors.primarycolor)),
            child: Row(
              children: [
                Text("التاريح",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: Appcolors.primarycolor)),
                Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: Appcolors.primarycolor)),
                Text(date,
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: Appcolors.maincolor))
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Appcolors.primarycolor)),
            child: Row(
              children: [
                const Text("البيان",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: Appcolors.primarycolor)),
                const Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: Appcolors.primarycolor)),
                Expanded(
                    child: Text(bayan,
                        style: TextStyle(
                            fontFamily: "cairo",
                            fontSize: 12.5,
                            color: Appcolors.maincolor)))
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Appcolors.primarycolor)),
            child: Row(
              children: [
                Text(type == "maintenance" ? "تكلفة الصيانه" : "المبلغ المدفوع",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: Appcolors.primarycolor)),
                const Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: Appcolors.primarycolor)),
                Expanded(
                    child: Text(price,
                        style: TextStyle(
                            fontFamily: "cairo",
                            fontSize: 12.5,
                            color: Appcolors.maincolor)))
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Appcolors.primarycolor)),
            child: Row(
              children: [
                const Text("الموظف",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: Appcolors.primarycolor)),
                const Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: Appcolors.primarycolor)),
                Expanded(
                    child: Text(employeename,
                        style: TextStyle(
                            fontFamily: "cairo",
                            fontSize: 12.5,
                            color: Appcolors.maincolor)))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
