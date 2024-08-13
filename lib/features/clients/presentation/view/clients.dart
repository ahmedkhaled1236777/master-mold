import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/constants.dart';
import 'package:mastermold/core/commn/dialogerror.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/navigation.dart';
import 'package:mastermold/core/commn/sharedpref/cashhelper.dart';
import 'package:mastermold/core/commn/shimmer/shimmer.dart';
import 'package:mastermold/core/commn/showdialogerror.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/core/commn/widgets/headerwidget.dart';
import 'package:mastermold/core/commn/widgets/nodata.dart';
import 'package:mastermold/features/actions/presentation/view/clientactions.dart';
import 'package:mastermold/features/clients/presentation/view/widgets/alertsearch.dart';
import 'package:mastermold/features/clients/presentation/view/widgets/clientitem.dart';
import 'package:mastermold/features/clients/presentation/view/widgets/editialog.dart';
import 'package:mastermold/features/clients/presentation/viewmodel/client/client_cubit.dart';

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
  ScrollController scrollController = ScrollController();

  getdata() async {
    BlocProvider.of<ClientCubit>(context).queryparms = null;
    BlocProvider.of<ClientCubit>(context).getclients(page: 1);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await BlocProvider.of<ClientCubit>(context).getamoreclients();
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
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      BlocProvider.of<ClientCubit>(context).firstloading =
                          false;
                      BlocProvider.of<ClientCubit>(context).queryparms = null;
                      await BlocProvider.of<ClientCubit>(context)
                          .getclients(page: 1);
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
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
                                content: Alertsearch());
                          });
                    },
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
              Expanded(child: BlocBuilder<ClientCubit, ClientState>(
                builder: (context, state) {
                  if (state is getclientsloading) return loadingshimmer();
                  if (state is getclientsfailure) return SizedBox();
                  return BlocProvider.of<ClientCubit>(context).data.isEmpty
                      ? nodata()
                      : ListView.separated(
                          controller: scrollController,
                          itemBuilder: (context, i) => i >=
                                  BlocProvider.of<ClientCubit>(context)
                                      .data
                                      .length
                              ? loading()
                              : InkWell(
                                  onTap: () {
                                    navigateto(
                                        navigationscreen: clientaction(
                                            clientid:
                                                BlocProvider.of<ClientCubit>(
                                                        context)
                                                    .data[i]
                                                    .id!,
                                            clientname:
                                                BlocProvider.of<ClientCubit>(
                                                        context)
                                                    .data[i]
                                                    .name!),
                                        context: context);
                                  },
                                  child: customtableclientitem(
                                      edit: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0)),
                                                    title: Container(
                                                      height: 20,
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: Icon(
                                                            Icons.close,
                                                            color: Appcolors
                                                                .maincolor,
                                                          )),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    backgroundColor:
                                                        Colors.white,
                                                    insetPadding:
                                                        EdgeInsets.all(35),
                                                    content: editdialog(
                                                        name: TextEditingController(
                                                            text: BlocProvider
                                                                    .of<ClientCubit>(
                                                                        context)
                                                                .data[i]
                                                                .name!),
                                                        phone: TextEditingController(
                                                            text:
                                                                BlocProvider.of<ClientCubit>(context)
                                                                    .data[i]
                                                                    .phone),
                                                        fac: TextEditingController(
                                                            text:
                                                                BlocProvider.of<ClientCubit>(context)
                                                                    .data[i]
                                                                    .industry),
                                                        client_id:
                                                            BlocProvider.of<ClientCubit>(
                                                                    context)
                                                                .data[i]
                                                                .id!),
                                                  );
                                                });
                                          },
                                          icon: Icon(editeicon)),
                                      clientname:
                                          BlocProvider.of<ClientCubit>(context)
                                              .data[i]
                                              .name!,
                                      phone:
                                          BlocProvider.of<ClientCubit>(context)
                                              .data[i]
                                              .phone!,
                                      fac: BlocProvider.of<ClientCubit>(context)
                                          .data[i]
                                          .industry!,
                                      delet: IconButton(
                                          onPressed: () {
                                            cashhelper.getdata(
                                                        key: "is_manager") !=
                                                    "yes"
                                                ? showdialogerror(
                                                    error:
                                                        "ليس لديك صلاحية حذف العملاء",
                                                    context: context)
                                                : awsomdialogerror(
                                                    context: context,
                                                    mywidget: BlocConsumer<
                                                        ClientCubit,
                                                        ClientState>(
                                                      listener:
                                                          (context, state) {
                                                        if (state
                                                            is deleteclientssuccess) {
                                                          Navigator.pop(
                                                              context);

                                                          showtoast(
                                                              message: state
                                                                  .success_message,
                                                              toaststate:
                                                                  Toaststate
                                                                      .succes);
                                                        }
                                                        if (state
                                                            is deleteclientsfailure) {
                                                          Navigator.pop(
                                                              context);

                                                          showtoast(
                                                              message: state
                                                                  .error_message,
                                                              toaststate:
                                                                  Toaststate
                                                                      .error);
                                                        }
                                                      },
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is deleteclientsloading)
                                                          return deleteloading();
                                                        return SizedBox(
                                                          height: 50,
                                                          width: 100,
                                                          child: ElevatedButton(
                                                              style:
                                                                  const ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStatePropertyAll(
                                                                        Color.fromARGB(
                                                                            255,
                                                                            37,
                                                                            163,
                                                                            42)),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                await BlocProvider.of<
                                                                            ClientCubit>(
                                                                        context)
                                                                    .deleteclient(
                                                                        client_id: BlocProvider.of<ClientCubit>(context)
                                                                            .data[i]
                                                                            .id!);
                                                              },
                                                              child: const Text(
                                                                "تاكيد",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )),
                                                        );
                                                      },
                                                    ),
                                                    tittle:
                                                        "هل تريد حذف بيانات العميل ${BlocProvider.of<ClientCubit>(context).data[i].name}");
                                          },
                                          icon: Icon(
                                            deleteicon,
                                            color: Colors.red,
                                          ))),
                                ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount:
                              BlocProvider.of<ClientCubit>(context).loading ==
                                      true
                                  ? BlocProvider.of<ClientCubit>(context)
                                          .data
                                          .length +
                                      1
                                  : BlocProvider.of<ClientCubit>(context)
                                      .data
                                      .length);
                },
              ))
            ])));
  }
}
