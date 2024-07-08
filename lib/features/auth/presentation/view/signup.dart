import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/core/styles/style.dart';
import 'package:mastermold/features/auth/presentation/view/widgets/customtextform.dart';
import 'package:mastermold/features/auth/presentation/viewmodel/auth/auth_cubit.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

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
                    controller: name,
                    prefixicon: Icons.person,
                    hintText: "الاسم",
                    val: "برجاء ادخال الاسم",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customtextform(
                    controller: phone,
                    prefixicon: Icons.phone,
                    hintText: "رقم الهاتف",
                    val: "برجاء ادخال رقم الهاتف",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customtextform(
                    controller: email,
                    prefixicon: Icons.email,
                    hintText: "البريد الالكتروني",
                    val: "برجاء ادخال البريد الالكتروني",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customtextform(
                    controller: password,
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
                    hintText: "كلمة المرور",
                    val: "برجاء ادخال كلمة المرور",
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is signupfailure) {
                        showtoast(
                            message: state.errorr_message,
                            toaststate: Toaststate.error);
                      }
                      if (state is signupsuccess) {
                        showtoast(
                            message: state.successmessage,
                            toaststate: Toaststate.succes);
                      }
                    },
                    builder: (context, state) {
                      if (state is signuploading) return loading();
                      return custommaterialbutton(
                        button_name: "انشاء حساب",
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await BlocProvider.of<AuthCubit>(context).sigup(
                                name: name.text,
                                password: password.text,
                                phone: phone.text,
                                email: email.text);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " امتلك حساب ؟",
                        style: Appstyles.textStyle13w,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "تسجيل دخول",
                        style: Appstyles.textStyle13am,
                      ),
                    ],
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
