import 'package:flutter/material.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/constants.dart';
import 'package:mastermold/core/commn/widgets/headerwidget.dart';
import 'package:mastermold/features/clients/presentation/view/widgets/clientitem.dart';

class clients extends StatefulWidget {
  @override
  State<clients> createState() => _clientsState();
}

class _clientsState extends State<clients> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final clientsheader = [
    "اسم العميل",
    "رقم الهاتف",
    "اسم المصنع",
    "تعديل",
    "حذف",
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
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: Appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "العملاء",
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
                    children: clientsheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, i) => InkWell(
                            onTap: () {},
                            child: customtableclientitem(
                                edit: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      editeicon,
                                      color: Appcolors.dropcolor,
                                    )),
                                clientname: "احمد",
                                phone: "0155525788",
                                fac: "ميجا",
                                delet: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      deleteicon,
                                      color: Colors.red,
                                    ))),
                          ),
                      separatorBuilder: (context, i) => Divider(
                            color: Colors.grey,
                          ),
                      itemCount: 5))
            ])));
  }
}
