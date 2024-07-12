import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/core/commn/widgets/customtextform.dart';
import 'package:mastermold/features/clients/presentation/viewmodel/client/client_cubit.dart';

class Addclient extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController fac = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
            "العملاء",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "cairo",
                fontSize: 15,
                fontWeight: FontWeight.bold),
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
                  custommytextform(
                    controller: name,
                    hintText: "اسم العميل",
                    val: "برجاء ادخال اسم العميل",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  custommytextform(
                    keyboardType: TextInputType.number,
                    controller: phone,
                    hintText: "رقم الهاتف",
                    val: "برجاء ادخال هاتف العميل",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  custommytextform(
                    controller: fac,
                    hintText: "اسم المصنع",
                    val: "برجاء ادخال اسم المصنع",
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  BlocConsumer<ClientCubit, ClientState>(
                    listener: (context, state) {
                      if (state is addCliensuccess) {
                        name.clear;
                        fac.clear();
                        phone.clear();
                        showtoast(
                            message: state.successmessage,
                            toaststate: Toaststate.succes);
                      }
                      if (state is addClientfailure)
                        showtoast(
                            message: state.errorr_message,
                            toaststate: Toaststate.error);
                    },
                    builder: (context, state) {
                      if (state is addClientloadind) return loading();
                      return custommaterialbutton(
                        button_name: "تسجيل عميل",
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await BlocProvider.of<ClientCubit>(context)
                                .addclient(
                                    name: name.text,
                                    phone: phone.text,
                                    fac: fac.text);
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
