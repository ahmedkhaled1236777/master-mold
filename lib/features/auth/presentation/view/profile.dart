import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/navigation.dart';
import 'package:mastermold/core/commn/sharedpref/cashhelper.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/features/auth/presentation/view/changepass.dart';
import 'package:mastermold/features/auth/presentation/view/login.dart';
import 'package:mastermold/features/auth/presentation/view/updateprofile.dart';
import 'package:mastermold/features/auth/presentation/viewmodel/auth/auth_cubit.dart';

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  File? image;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Appcolors.maincolor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  height: h * 0.35,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              navigateto(
                                  navigationscreen: Updateprofile(
                                      name: TextEditingController(
                                          text:
                                              cashhelper.getdata(key: "name")),
                                      phone: TextEditingController(
                                          text:
                                              cashhelper.getdata(key: "phone")),
                                      email: TextEditingController(
                                          text: cashhelper.getdata(
                                              key: "email"))),
                                  context: context);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top:
                                (MediaQuery.of(context).size.height * 0.1) / 6),
                        child: Center(
                          child: const Text(
                            "الملف الشخصي",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'cairo',
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "${"الاسم"} : ",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                              ),
                              Text(
                                cashhelper.getdata(key: "name"),
                                style: const TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "${"رقم الهاتف"} : ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "cairo",
                                ),
                              ),
                              if (cashhelper.getdata(key: "phone") != null)
                                Text(
                                  cashhelper.getdata(key: "phone"),
                                  style: const TextStyle(
                                      color: Colors.white, fontFamily: "cairo"),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "${"البريد الالكتروني"} : ",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                              ),
                              Text(
                                cashhelper.getdata(key: "email"),
                                style: const TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(
                                  child: Text(
                                "تغيير كلمة المرور",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                              )),
                              IconButton(
                                  onPressed: () async {
                                    navigateto(
                                        navigationscreen: changepass(),
                                        context: context);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(
                                  child: Text(
                                "تسجيل الخروج",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                              )),
                              BlocConsumer<AuthCubit, AuthState>(
                                listener: (context, state) {
                                  if (state is logoutfailure) {
                                    showtoast(
                                        message: state.errorrmessage,
                                        toaststate: Toaststate.error);
                                  }
                                  if (state is logoutsuccess) {
                                    cashhelper.cleardata();
                                    navigateandfinish(
                                        navigationscreen: Login(),
                                        context: context);
                                    showtoast(
                                        message: state.successmessage,
                                        toaststate: Toaststate.succes);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is logoutloading)
                                    return deleteloading();
                                  return IconButton(
                                      onPressed: () async {
                                        await BlocProvider.of<AuthCubit>(
                                                context)
                                            .logout();
                                      },
                                      icon: const Icon(
                                        Icons.logout,
                                        color: Colors.red,
                                      ));
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            Positioned(
                top: h * 0.35 - 50,
                left: w * 0.5 - 50,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    cashhelper.getdata(key: "image") == null
                        ? const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage:
                                  AssetImage("assets/images/master.jpg"),
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            child: image != null
                                ? CircleAvatar(
                                    radius: 45,
                                    backgroundImage: FileImage(image!))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: SizedBox(
                                      height: 90,
                                      width: 90,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            cashhelper.getdata(key: "image"),
                                        errorWidget: (context, url, Widget) {
                                          return const Icon(
                                            Icons.person,
                                            color: Colors.red,
                                          );
                                        },
                                        placeholder: (context, url) {
                                          return CircularProgressIndicator();
                                        },
                                      ),
                                    ),
                                  ),
                          ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
