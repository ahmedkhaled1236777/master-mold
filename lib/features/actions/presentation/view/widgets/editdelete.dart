import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/commn/date/date_cubit.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/core/commn/widgets/choosedate.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/core/commn/widgets/customtextform.dart';
import 'package:mastermold/features/actions/data/model/actionmodelrequest.dart';
import 'package:mastermold/features/actions/presentation/view/widgets/editdeleteradio.dart';
import 'package:mastermold/features/actions/presentation/view/widgets/radios.dart';
import 'package:mastermold/features/actions/presentation/viewmodel/cubit/clientactions_cubit.dart';

class Editdelete extends StatelessWidget {
  final TextEditingController bayan;
  final TextEditingController price;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final int clientid;
  final int actionid;

  Editdelete(
      {super.key,
      required this.bayan,
      required this.price,
      required this.clientid,
      required this.actionid});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<ClientactionsCubit, ClientactionsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  BlocBuilder<ClientactionsCubit, ClientactionsState>(
                    builder: (context, state) {
                      return Editdeleteradio(
                          firstradio: "تعديل",
                          secondradio: "حذف",
                          firstradiotitle: "تعديل",
                          secondradiotitle: "حذف");
                    },
                  ),
                  BlocProvider.of<ClientactionsCubit>(context).editordelete ==
                          "تعديل"
                      ? Column(
                          children: [
                            BlocBuilder<ClientactionsCubit, ClientactionsState>(
                              builder: (context, state) {
                                return radios(
                                    firstradio: "maintenance",
                                    secondradio: "payment",
                                    firstradiotitle: "مبلغ الصيانه",
                                    secondradiotitle: "المبلغ المدفوع");
                              },
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date1,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate(context);
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              controller: bayan,
                              maxlines: 3,
                              hintText: "البيان",
                              val: "برجاء ادخال البيان",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<ClientactionsCubit, ClientactionsState>(
                              builder: (context, state) {
                                return custommytextform(
                                  keyboardType: TextInputType.number,
                                  controller: price,
                                  hintText: BlocProvider.of<ClientactionsCubit>(
                                                  context)
                                              .type ==
                                          "maintenance"
                                      ? "مبلغ الصيانه"
                                      : "المبلغ المدفوع",
                                  val: "برجاء ادخال المبلغ",
                                );
                              },
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            BlocConsumer<ClientactionsCubit,
                                ClientactionsState>(
                              listener: (context, state) async {
                                if (state is editactionsuccess) {
                                  Navigator.pop(context);
                                  BlocProvider.of<DateCubit>(context)
                                      .cleardates();
                                  BlocProvider.of<ClientactionsCubit>(context)
                                      .changetype(value: "maintenance");
                                  bayan.clear;
                                  price.clear();
                                  await BlocProvider.of<ClientactionsCubit>(
                                          context)
                                      .getactions(client_id: clientid);
                                  showtoast(
                                      context: context,
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes);
                                }
                                if (state is editactionfailure)
                                  showtoast(
                                      context: context,
                                      message: state.errormessage,
                                      toaststate: Toaststate.error);
                              },
                              builder: (context, state) {
                                if (state is editactionloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تعديل",
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      await BlocProvider.of<
                                              ClientactionsCubit>(context)
                                          .editaction(
                                              actionid: actionid,
                                              actiomodelrequest: Actionmodelrequest(
                                                  type: BlocProvider.of<
                                                              ClientactionsCubit>(
                                                          context)
                                                      .type,
                                                  date: BlocProvider.of<
                                                          DateCubit>(context)
                                                      .date1,
                                                  desc: bayan.text,
                                                  clientid: clientid,
                                                  price:
                                                      double.parse(price.text)
                                                          .round()));
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        )
                      : Column(children: [
                          Text(
                            "هل تريد حذف البيان ؟",
                            style: TextStyle(fontFamily: "cairo"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color(0xffc21a15)),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "الغاء",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                BlocConsumer<ClientactionsCubit,
                                    ClientactionsState>(
                                  listener: (context, state) {
                                    if (state is deleteactionsuccess) {
                                      Navigator.pop(context);

                                      showtoast(
                                          context: context,
                                          message: state.successmessage,
                                          toaststate: Toaststate.succes);
                                    }
                                    if (state is deleteactionfailure) {
                                      Navigator.pop(context);

                                      showtoast(
                                          context: context,
                                          message: state.errormessage,
                                          toaststate: Toaststate.error);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is deleteactionloading)
                                      return deleteloading();
                                    return SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: ElevatedButton(
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color.fromARGB(
                                                        255, 37, 163, 42)),
                                          ),
                                          onPressed: () async {
                                            await BlocProvider.of<
                                                    ClientactionsCubit>(context)
                                                .deleteaction(
                                                    actionid: actionid);
                                          },
                                          child: const Text(
                                            "تاكيد",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "cairo",
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          )),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ]),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
