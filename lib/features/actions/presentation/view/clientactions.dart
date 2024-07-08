import 'package:flutter/material.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/widgets/headerwidget.dart';
import 'package:mastermold/features/actions/presentation/view/widgets/clientaction.dart';

class clientaction extends StatefulWidget {
  @override
  State<clientaction> createState() => _clientactionState();
}

// ignore: camel_case_types
class _clientactionState extends State<clientaction> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");
  bool val = false;
  final clientactionheader = [
    "التاريخ",
    "البيان",
    "تكلفة\nالصيانه",
    "المبلغ\nالمدفوع",
    "تحديد",
  ];

  getdata() async {}
  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: Appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "م.احمد علام",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(children: [
              Container(
                height: 50,
                color: Appcolors.dropcolor,
                child: Row(
                    children: clientactionheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تحديد" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, i) => InkWell(
                            onTap: () {},
                            child: customtableclientactionitem(
                              payment: "20000",
                              date: "22/5/2024",
                              check: Checkbox(value: val, onChanged: (val) {}),
                              bayan: "اصلاح اسطبة شاسيه",
                            ),
                          ),
                      separatorBuilder: (context, i) => const Divider(
                            color: Colors.grey,
                          ),
                      itemCount: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.picture_as_pdf,
                        color: Appcolors.dropcolor,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share,
                        color: Appcolors.dropcolor,
                      )),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 7),
                width: double.infinity,
                color: Appcolors.dropcolor,
                child: const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "اجمالي ما له : 12365552",
                        style:
                            TextStyle(fontFamily: "cairo", color: Colors.white),
                      ),
                      Text(
                        "اجمالي ما عليه : 0",
                        style:
                            TextStyle(fontFamily: "cairo", color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ])));
  }
}
