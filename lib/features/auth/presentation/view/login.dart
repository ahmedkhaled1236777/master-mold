import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/navigation.dart';
import 'package:mastermold/core/commn/sharedpref/cashhelper.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/core/styles/style.dart';
import 'package:mastermold/features/auth/presentation/view/profile.dart';
import 'package:mastermold/features/auth/presentation/view/signup.dart';
import 'package:mastermold/features/auth/presentation/view/widgets/customtextform.dart';
import 'package:mastermold/features/auth/presentation/viewmodel/auth/auth_cubit.dart';
import 'package:mastermold/features/home/presentation/view/home.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();

  bool x = true;
  @override
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Appcolors.maincolor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width > 950
                    ? MediaQuery.sizeOf(context).width * 0.3
                    : MediaQuery.sizeOf(context).width > 650
                        ? MediaQuery.sizeOf(context).width * 0.2
                        : 20,
                vertical: 20),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Image.asset("assets/images/master.jpg"),
                  const SizedBox(
                    height: 10,
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
                      if (state is signinfailure) {
                        showtoast(
                            context: context,
                            message: state.errorr_message,
                            toaststate: Toaststate.error);
                      }
                      if (state is signinsuccess) {
                        if (state.loginmodel.user!.isActive != "yes") {
                          showtoast(
                              context: context,
                              message: "البريد غير مفعل",
                              toaststate: Toaststate.error);
                        } else {
                          cashhelper.setdata(
                              key: "name", value: state.loginmodel.user!.name!);
                          cashhelper.setdata(
                              key: "token",
                              value: "Bearer ${state.loginmodel.user!.token}");
                          if (state.loginmodel.user!.profilePhotoPath != null)
                            cashhelper.setdata(
                                key: "image",
                                value:
                                    "http://master-mold.masool.net/uploads/${state.loginmodel.user!.profilePhotoPath}");
                          cashhelper.setdata(
                              key: "email",
                              value: state.loginmodel.user!.email);
                          cashhelper.setdata(
                              key: "phone",
                              value: state.loginmodel.user!.phone);
                          cashhelper.setdata(
                              key: "is_manager",
                              value: state.loginmodel.user!.isManager);
                          navigateandfinish(
                              navigationscreen: home(), context: context);
                          showtoast(
                              context: context,
                              message: "تم تسجيل الدخول بنجاح",
                              toaststate: Toaststate.succes);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is signinloading) return loading();
                      return custommaterialbutton(
                        button_name: "تسجيل دخول",
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await BlocProvider.of<AuthCubit>(context).sigin(
                                fcm:
                                    "aa", // OneSignal.User.pushSubscription.id!,
                                password: password.text,
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
                        "  لا امتلك حساب ؟",
                        style: Appstyles.textStyle13w,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          navigateto(
                              navigationscreen: Signup(), context: context);
                        },
                        child: Text(
                          "انشاء حساب",
                          style: Appstyles.textStyle13am,
                        ),
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
