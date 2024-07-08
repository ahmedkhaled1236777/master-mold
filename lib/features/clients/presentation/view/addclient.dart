import 'package:flutter/material.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/core/commn/widgets/customtextform.dart';

class Addclient extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController fac = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: Appcolors.maincolor,
          centerTitle: true,
          title: Text(
            "اضافة عميل",
            style: TextStyle(fontFamily: "cairo", color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                custommytextform(controller: name, hintText: "اسم العميل"),
                SizedBox(
                  height: 10,
                ),
                custommytextform(controller: phone, hintText: "رقم الهاتف"),
                SizedBox(
                  height: 10,
                ),
                custommytextform(controller: fac, hintText: "اسم المصنع"),
                SizedBox(
                  height: 35,
                ),
                custommaterialbutton(button_name: "تسجيل عميل")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
