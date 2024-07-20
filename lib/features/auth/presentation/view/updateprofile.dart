import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/navigation.dart';
import 'package:mastermold/core/commn/sharedpref/cashhelper.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/core/styles/style.dart';
import 'package:mastermold/features/auth/presentation/view/login.dart';
import 'package:mastermold/features/auth/presentation/view/widgets/customtextform.dart';
import 'package:mastermold/features/auth/presentation/viewmodel/auth/auth_cubit.dart';
import 'package:mastermold/features/home/presentation/view/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

class Updateprofile extends StatefulWidget {
  final TextEditingController name;

  final TextEditingController phone;

  final TextEditingController email;

  const Updateprofile(
      {super.key,
      required this.name,
      required this.phone,
      required this.email});
  @override
  State<Updateprofile> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  File? photo;
  uploadimage() async {
    final ImagePicker picker = ImagePicker();

    var pikedimage = await picker.pickImage(source: ImageSource.gallery);
    if (pikedimage != null) {
      photo = File(pikedimage.path);
      setState(() {});
    }
  }

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
                    height: 85,
                  ),
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      photo == null
                          ? cashhelper.getdata(key: "image") == null
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey[100],
                                  radius: 45.0,
                                  backgroundImage: AssetImage(
                                    'assets/images/master.jpg',
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(45),
                                  child: CachedNetworkImage(
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.fill,
                                    imageUrl: cashhelper.getdata(key: "image"),
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
                                )
                          : CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              radius: 45.0,
                              backgroundImage: FileImage(
                                photo!,
                              ),
                            ),
                      IconButton(
                          onPressed: () {
                            uploadimage();
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  customtextform(
                    controller: widget.name,
                    prefixicon: Icons.person,
                    hintText: "الاسم",
                    val: "برجاء ادخال الاسم",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customtextform(
                    keyboardType: TextInputType.number,
                    controller: widget.phone,
                    prefixicon: Icons.phone,
                    hintText: "رقم الهاتف",
                    val: "برجاء ادخال رقم الهاتف",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customtextform(
                    controller: widget.email,
                    prefixicon: Icons.email,
                    hintText: "البريد الالكتروني",
                    val: "برجاء ادخال البريد الالكتروني",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is updateprofilefailure) {
                        showtoast(
                            message: state.errormessage,
                            toaststate: Toaststate.error);
                      }
                      if (state is updateprofilesuccess) {
                        if (state.success.data!.profilePhotoPath != null) {
                          cashhelper.setdata(
                              key: "image",
                              value: state.success.data!.profilePhotoPath);
                        }
                        cashhelper.setdata(
                            key: "name", value: state.success.data!.name);
                        cashhelper.setdata(
                            key: "email", value: state.success.data!.email);
                        cashhelper.setdata(
                            key: "phone", value: state.success.data!.phone);
                        navigateandfinish(
                            navigationscreen: home(), context: context);

                        showtoast(
                            message: "تم تعديل البيانات بنجاح",
                            toaststate: Toaststate.succes);
                      }
                    },
                    builder: (context, state) {
                      if (state is updateprofileloading) return loading();
                      return custommaterialbutton(
                        button_name: "تعديل البيانات",
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await BlocProvider.of<AuthCubit>(context)
                                .updateprofile(
                                    photo: photo,
                                    name: widget.name.text,
                                    phone: widget.phone.text,
                                    email: widget.email.text);
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
