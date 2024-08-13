import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/date/date_cubit.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/core/commn/widgets/choosedate.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/core/commn/widgets/customtextform.dart';
import 'package:mastermold/features/actions/data/model/actionmodelrequest.dart';
import 'package:mastermold/features/actions/presentation/view/widgets/radios.dart';
import 'package:mastermold/features/actions/presentation/viewmodel/cubit/clientactions_cubit.dart';

class Addaction extends StatefulWidget {
  final int client_id;

  Addaction({super.key, required this.client_id});

  @override
  State<Addaction> createState() => _AddactionState();
}

class _AddactionState extends State<Addaction> {
  TextEditingController bayan = TextEditingController();

  TextEditingController money = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    BlocProvider.of<DateCubit>(context).cleardates();
    BlocProvider.of<ClientactionsCubit>(context)
        .changetype(value: "maintenance");
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
          backgroundColor: Appcolors.maincolor,
          centerTitle: true,
          title: const Text(
            "اضافة حركه",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
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
                        date: BlocProvider.of<DateCubit>(context).date1,
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
                        controller: money,
                        hintText:
                            BlocProvider.of<ClientactionsCubit>(context).type ==
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
                  BlocConsumer<ClientactionsCubit, ClientactionsState>(
                    listener: (context, state) async {
                      if (state is addactionsuccess) {
                        BlocProvider.of<DateCubit>(context).cleardates();
                        BlocProvider.of<ClientactionsCubit>(context)
                            .changetype(value: "maintenance");
                        bayan.clear();
                        money.clear();
                        await BlocProvider.of<ClientactionsCubit>(context)
                            .getactions(client_id: widget.client_id);
                        showtoast(
                            message: state.successmessage,
                            toaststate: Toaststate.succes);
                      }
                      if (state is addactionfailure)
                        showtoast(
                            message: state.errormessage,
                            toaststate: Toaststate.error);
                    },
                    builder: (context, state) {
                      if (state is addactionloading) return loading();
                      return custommaterialbutton(
                        button_name: "تسجيل",
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await BlocProvider.of<ClientactionsCubit>(context)
                                .addaction(
                                    actiomodelrequest: Actionmodelrequest(
                                        type: BlocProvider.of<
                                                ClientactionsCubit>(context)
                                            .type,
                                        date:
                                            BlocProvider.of<DateCubit>(context)
                                                .date1,
                                        desc: bayan.text,
                                        clientid: widget.client_id,
                                        price:
                                            double.parse(money.text).round()));
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
