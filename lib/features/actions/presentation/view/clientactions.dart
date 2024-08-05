import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/date/date_cubit.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/navigation.dart';
import 'package:mastermold/core/commn/shimmer/shimmer.dart';
import 'package:mastermold/core/commn/showdialogerror.dart';
import 'package:mastermold/core/commn/widgets/headerwidget.dart';
import 'package:mastermold/core/commn/widgets/nodata.dart';
import 'package:mastermold/core/commn/widgets/pdf.dart';
import 'package:mastermold/features/actions/presentation/view/addaction.dart';
import 'package:mastermold/features/actions/presentation/view/widgets/alertcontent.dart';
import 'package:mastermold/features/actions/presentation/view/widgets/clientaction.dart';
import 'package:mastermold/features/actions/presentation/view/widgets/editdelete.dart';
import 'package:mastermold/features/actions/presentation/viewmodel/cubit/clientactions_cubit.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/model/actionmodel/datum.dart';

class clientaction extends StatefulWidget {
  ScrollController scrollController = ScrollController();
  final int clientid;
  final String clientname;

  clientaction({super.key, required this.clientid, required this.clientname});
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

  getdata() async {
    BlocProvider.of<ClientactionsCubit>(context).firstloading = false;
    BlocProvider.of<ClientactionsCubit>(context).queryparms = null;
    BlocProvider.of<ClientactionsCubit>(context)
        .getactions(client_id: widget.clientid);
    widget.scrollController.addListener(() async {
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent) {
        await BlocProvider.of<ClientactionsCubit>(context)
            .getamoreclients(client_id: widget.clientid);
      }
    });
  }

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
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                title: Container(
                                  height: 20,
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Appcolors.maincolor,
                                      )),
                                ),
                                contentPadding: EdgeInsets.all(10),
                                backgroundColor: Colors.white,
                                insetPadding: EdgeInsets.all(35),
                                content: Alertcontent(
                                  clientid: widget.clientid,
                                ));
                          });
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      navigateto(
                          navigationscreen: Addaction(
                            client_id: widget.clientid,
                          ),
                          context: context);
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: Appcolors.maincolor,
              centerTitle: true,
              title: Text(
                widget.clientname,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
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
                  child: BlocConsumer<ClientactionsCubit, ClientactionsState>(
                listener: (context, state) {
                  if (state is Clientactionsfailurre)
                    showdialogerror(
                        error: state.errormessage, context: context);
                },
                builder: (context, state) {
                  if (state is Clientactionsloading) return loadingshimmer();
                  if (state is Clientactionsfailurre)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<ClientactionsCubit>(context)
                        .data
                        .isEmpty) return nodata();
                    return ListView.separated(
                        controller: widget.scrollController,
                        itemBuilder: (context, i) => i >=
                                BlocProvider.of<ClientactionsCubit>(context)
                                    .data
                                    .length
                            ? loading()
                            : InkWell(
                                onTap: () {
                                  BlocProvider.of<ClientactionsCubit>(context)
                                      .editordelete = "تعديل";
                                  BlocProvider.of<ClientactionsCubit>(context)
                                          .type =
                                      BlocProvider.of<ClientactionsCubit>(
                                              context)
                                          .data[i]
                                          .type!;
                                  BlocProvider.of<DateCubit>(context).date1 =
                                      BlocProvider.of<ClientactionsCubit>(
                                              context)
                                          .data[i]
                                          .date!;

                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0)),
                                            title: Container(
                                              height: 20,
                                              alignment: Alignment.topLeft,
                                              child: IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Appcolors.maincolor,
                                                  )),
                                            ),
                                            contentPadding: EdgeInsets.all(10),
                                            backgroundColor: Colors.white,
                                            insetPadding: EdgeInsets.all(35),
                                            content: Editdelete(
                                                bayan: TextEditingController(
                                                    text: BlocProvider.of<
                                                                ClientactionsCubit>(
                                                            context)
                                                        .data[i]
                                                        .description),
                                                price: TextEditingController(
                                                    text: BlocProvider.of<
                                                                ClientactionsCubit>(
                                                            context)
                                                        .data[i]
                                                        .price!
                                                        .toString()),
                                                clientid: widget.clientid,
                                                actionid: BlocProvider.of<
                                                        ClientactionsCubit>(context)
                                                    .data[i]
                                                    .id!));
                                      });
                                },
                                child: customtableclientactionitem(
                                  payment: BlocProvider.of<ClientactionsCubit>(
                                                  context)
                                              .data[i]
                                              .type ==
                                          "maintenance"
                                      ? ""
                                      : BlocProvider.of<ClientactionsCubit>(
                                              context)
                                          .data[i]
                                          .price!
                                          .toString(),
                                  maintenance:
                                      BlocProvider.of<ClientactionsCubit>(
                                                      context)
                                                  .data[i]
                                                  .type ==
                                              "payment"
                                          ? ""
                                          : BlocProvider.of<ClientactionsCubit>(
                                                  context)
                                              .data[i]
                                              .price!
                                              .toString(),
                                  date: BlocProvider.of<ClientactionsCubit>(
                                          context)
                                      .data[i]
                                      .date!,
                                  check: Checkbox(
                                      value:
                                          BlocProvider.of<ClientactionsCubit>(
                                                  context)
                                              .checks[i],
                                      onChanged: (val) {
                                        BlocProvider.of<ClientactionsCubit>(
                                                context)
                                            .changecheckbox(val!, i);
                                      }),
                                  bayan: BlocProvider.of<ClientactionsCubit>(
                                          context)
                                      .data[i]
                                      .description!,
                                ),
                              ),
                        separatorBuilder: (context, i) => const Divider(
                              color: Colors.grey,
                            ),
                        itemCount: BlocProvider.of<ClientactionsCubit>(context)
                                    .loading ==
                                true
                            ? BlocProvider.of<ClientactionsCubit>(context)
                                    .data
                                    .length +
                                1
                            : BlocProvider.of<ClientactionsCubit>(context)
                                .data
                                .length);
                  }
                },
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () async {
                        List<Datum> data = [];
                        for (int i = 0;
                            i <
                                BlocProvider.of<ClientactionsCubit>(context)
                                    .data
                                    .length;
                            i++) {
                          if (BlocProvider.of<ClientactionsCubit>(context)
                                  .checks[i] ==
                              true) {
                            data.add(
                                BlocProvider.of<ClientactionsCubit>(context)
                                    .data[i]);
                          }
                        }
                        final img =
                            await rootBundle.load('assets/images/logo.png');
                        final imageBytes = img.buffer.asUint8List();
                        File file = await pdfservice.generatepdf(
                            data,
                            widget.clientname,
                            imageBytes,
                            BlocProvider.of<ClientactionsCubit>(context)
                                        .maintenance <
                                    BlocProvider.of<ClientactionsCubit>(context)
                                        .payment
                                ? 0
                                : BlocProvider.of<ClientactionsCubit>(context)
                                        .maintenance -
                                    BlocProvider.of<ClientactionsCubit>(context)
                                        .payment,
                            BlocProvider.of<ClientactionsCubit>(context)
                                        .maintenance >
                                    BlocProvider.of<ClientactionsCubit>(context)
                                        .payment
                                ? 0
                                : BlocProvider.of<ClientactionsCubit>(context)
                                        .payment -
                                    BlocProvider.of<ClientactionsCubit>(context)
                                        .maintenance);
                        pdfservice.openfile(file);
                      },
                      icon: const Icon(
                        Icons.picture_as_pdf,
                        color: Appcolors.dropcolor,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () async {
                        List<Datum> data = [];
                        for (int i = 0;
                            i <
                                BlocProvider.of<ClientactionsCubit>(context)
                                    .data
                                    .length;
                            i++) {
                          if (BlocProvider.of<ClientactionsCubit>(context)
                                  .checks[i] ==
                              true) {
                            data.add(
                                BlocProvider.of<ClientactionsCubit>(context)
                                    .data[i]);
                          }
                        }
                        final img =
                            await rootBundle.load('assets/images/logo.png');
                        final imageBytes = img.buffer.asUint8List();
                        File file = await pdfservice.generatepdf(
                            data,
                            widget.clientname,
                            imageBytes,
                            BlocProvider.of<ClientactionsCubit>(context)
                                        .maintenance <
                                    BlocProvider.of<ClientactionsCubit>(context)
                                        .payment
                                ? 0
                                : BlocProvider.of<ClientactionsCubit>(context)
                                        .maintenance -
                                    BlocProvider.of<ClientactionsCubit>(context)
                                        .payment,
                            BlocProvider.of<ClientactionsCubit>(context)
                                        .maintenance >
                                    BlocProvider.of<ClientactionsCubit>(context)
                                        .payment
                                ? 0
                                : BlocProvider.of<ClientactionsCubit>(context)
                                        .payment -
                                    BlocProvider.of<ClientactionsCubit>(context)
                                        .maintenance);
                        await Share.shareXFiles([XFile(file.path)]);
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Appcolors.dropcolor,
                      )),
                ],
              ),
              BlocBuilder<ClientactionsCubit, ClientactionsState>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    width: double.infinity,
                    color: Appcolors.dropcolor,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "اجمالي ما له : ${BlocProvider.of<ClientactionsCubit>(context).maintenance > BlocProvider.of<ClientactionsCubit>(context).payment ? 0 : BlocProvider.of<ClientactionsCubit>(context).payment - BlocProvider.of<ClientactionsCubit>(context).maintenance}",
                            style: TextStyle(
                                fontFamily: "cairo", color: Colors.white),
                          ),
                          Text(
                            "اجمالي ما عليه : ${BlocProvider.of<ClientactionsCubit>(context).maintenance < BlocProvider.of<ClientactionsCubit>(context).payment ? 0 : BlocProvider.of<ClientactionsCubit>(context).maintenance - BlocProvider.of<ClientactionsCubit>(context).payment}",
                            style: TextStyle(
                                fontFamily: "cairo", color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ])));
  }
}
