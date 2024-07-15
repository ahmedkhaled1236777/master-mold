import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/navigation.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/features/auth/presentation/view/profile.dart';
import 'package:mastermold/features/auth/presentation/view/widgets/customtextform.dart';
import 'package:mastermold/features/auth/presentation/viewmodel/auth/auth_cubit.dart';

class changepass extends StatefulWidget {
  @override
  State<changepass> createState() => _changepassState();
}

class _changepassState extends State<changepass> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController oldpass = TextEditingController();

  TextEditingController newpass = TextEditingController();

  TextEditingController cnewpass = TextEditingController();

  bool x = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Appcolors.maincolor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset("assets/images/master.jpg"),
                  const SizedBox(
                    height: 10,
                  ),
                  customtextform(
                    controller: oldpass,
                    prefixicon: Icons.lock,
                    obscureText: x,
                    suffixIcon: IconButton(
                        onPressed: () {
                          x = !x;
                          setState(() {});
                        },
                        icon: Icon(
                          x ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white,
                        )),
                    hintText: "كلمة المرور القديمه",
                    val: "برجاء ادخال كلمة المرور القديمه",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customtextform(
                    controller: newpass,
                    prefixicon: Icons.lock,
                    obscureText: x,
                    suffixIcon: IconButton(
                        onPressed: () {
                          x = !x;
                          setState(() {});
                        },
                        icon: Icon(
                          x ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white,
                        )),
                    hintText: "كلمة المرور الجديده",
                    val: "برجاء ادخال كلمة المرور الجديده",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customtextform(
                    controller: cnewpass,
                    prefixicon: Icons.lock,
                    obscureText: x,
                    suffixIcon: IconButton(
                        onPressed: () {
                          x = !x;
                          setState(() {});
                        },
                        icon: Icon(
                          x ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white,
                        )),
                    hintText: "تاكيد كلمة المرور الجديده",
                    val: "برجاء ادخال تاكيد كلمة المرور الجديده",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is changepassfailure) {
                        showtoast(
                            message: state.errormessage,
                            toaststate: Toaststate.error);
                      }
                      if (state is changepasssuccess) {
                        Navigator.pop(context);
                        showtoast(
                            message: state.successmessage,
                            toaststate: Toaststate.succes);
                      }
                    },
                    builder: (context, state) {
                      if (state is changepassloading) return loading();
                      return custommaterialbutton(
                        button_name: "تغيير كلمة المرور",
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await BlocProvider.of<AuthCubit>(context)
                                .changepass(
                              oldpass: oldpass.text,
                              newpass: newpass.text,
                              cnewpass: cnewpass.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
