import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/showdialogerror.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/core/commn/widgets/customtextform.dart';
import 'package:mastermold/features/clients/presentation/viewmodel/client/client_cubit.dart';

class editdialog extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController fac;
  final int client_id;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  editdialog(
      {super.key,
      required this.name,
      required this.phone,
      required this.fac,
      required this.client_id});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
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
                  listener: (context, state) async {
                    if (state is editclientsuccess) {
                      name.clear;
                      fac.clear();
                      phone.clear();
                      showtoast(
                          message: state.success_message,
                          toaststate: Toaststate.succes);
                      await BlocProvider.of<ClientCubit>(context)
                          .getclients(page: 1);
                      Navigator.pop(context);
                    }
                    if (state is editclientfailure)
                      showdialogerror(
                          error: state.errorrmessage, context: context);
                  },
                  builder: (context, state) {
                    if (state is editclientloading) return loading();
                    return custommaterialbutton(
                      button_name: "تعديل البيانات",
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          await BlocProvider.of<ClientCubit>(context)
                              .editclient(
                                  name: name.text,
                                  phone: phone.text,
                                  fac: fac.text,
                                  client_id: client_id);
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
