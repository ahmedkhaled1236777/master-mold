import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/navigation.dart';
import 'package:mastermold/core/commn/sharedpref/cashhelper.dart';
import 'package:mastermold/core/commn/showdialogerror.dart';
import 'package:mastermold/features/actions/presentation/view/clientactions.dart';
import 'package:mastermold/features/actions/presentation/view/widgets/actindesc.dart';
import 'package:mastermold/features/auth/presentation/view/profile.dart';
import 'package:mastermold/features/clients/presentation/view/addclient.dart';
import 'package:mastermold/features/clients/presentation/view/clients.dart';
import 'package:mastermold/features/employees/presentation/views/employees.dart';
import 'package:mastermold/features/home/presentation/view/widgets/gridelement.dart';
import 'package:mastermold/features/managers/presentation/views/employees.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:avatar_glow/avatar_glow.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List homegrid = [
    {"name": "العملاء", "image": "assets/images/crm.png", "page": Addclient()},
    {
      "name": "حركة العملاء",
      "image": "assets/images/salary.png",
      "page": clients()
    },
    {
      "name": "الموظفين",
      "image": "assets/images/service.png",
      "page": employees()
    },
    if (cashhelper.getdata(key: "email") == "ahmedaaallam123@gmail.com")
      {
        "name": "المديرين",
        "image": "assets/images/service.png",
        "page": managers()
      },
  ];
  @override
  void initState() {
    /*  OneSignal.Notifications.addClickListener((event) {
      navigateto(
          navigationscreen: clientaction(
              clientid: event.notification.additionalData!["client_id"],
              clientname: event.notification.additionalData!["name_of_client"]),
          context: context);
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
                content: actiondesc(
                  employeename:
                      event.notification.additionalData!["name_of_employer"],
                  type: event.notification.additionalData!["type"],
                  price: event.notification.additionalData!["price"].toString(),
                  bayan: event.notification.additionalData!["description"],
                  date: event.notification.additionalData!["date"],
                ));
          });
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((e) {});*/
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    //stack overlaps widgets
                    Opacity(
                      //semi red clippath with more height and with 0.5 opacity
                      opacity: 0.2,
                      child: ClipPath(
                        clipper: WaveClipper(), //set our custom wave clipper
                        child: Container(
                          color: Appcolors.maincolor,
                          height: 185,
                        ),
                      ),
                    ),

                    ClipPath(
                      //upper clippath with less height
                      clipper: WaveClipper(), //set our custom wave clipper.
                      child: Container(
                        padding: EdgeInsets.only(bottom: 50),
                        color: Appcolors.maincolor,
                        height: 175,
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  cashhelper.getdata(key: "image") == null
                                      ? Material(
                                          // Replace this child with your own
                                          elevation: 8.0,
                                          shape: CircleBorder(),
                                          child: AvatarGlow(
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey[100],
                                              radius: 30.0,
                                              backgroundImage: AssetImage(
                                                'assets/images/master.jpg',
                                              ),
                                            ),
                                          ),
                                        )
                                      : Material(
                                          // Replace this child with your own
                                          elevation: 8.0,
                                          shape: CircleBorder(),
                                          child: AvatarGlow(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              child: CachedNetworkImage(
                                                height: 60,
                                                width: 60,
                                                fit: BoxFit.fill,
                                                imageUrl: cashhelper.getdata(
                                                    key: "image"),
                                                errorWidget:
                                                    (context, url, Widget) {
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      cashhelper.getdata(key: "name"),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        navigateto(
                                            navigationscreen: profile(),
                                            context: context);
                                      },
                                      icon: Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GridView.count(
                      childAspectRatio: 1 / .8,
                      crossAxisCount: MediaQuery.sizeOf(context).width > 950
                          ? 6
                          : MediaQuery.sizeOf(context).width > 650
                              ? 4
                              : 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: homegrid
                          .map((e) => Gridelement(
                                text: e["name"],
                                image: e["image"],
                                onTap: () {
                                  if (e["name"] == "الموظفين" &&
                                      cashhelper.getdata(key: "is_manager") !=
                                          "yes") {
                                    showdialogerror(
                                        error:
                                            "ليس لديك صلاحية الدخول لهذه الصفحه",
                                        context: context);
                                  } else
                                    navigateto(
                                      context: context,
                                      navigationscreen: e["page"],
                                    );
                                },
                              ))
                          .toList(),
                    ),
                  ),
                )
              ],
            ))));
  }
}

//Costom CLipper class with Path
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    double h = size.height;
    double w = size.width;
    path.lineTo(0, 0.9 * h);
    path.quadraticBezierTo(0.1 * w, 0.8 * h, 0.2 * w, 0.9 * h);

    path.quadraticBezierTo(0.3 * w, h, 0.4 * w, 0.9 * h);
    path.quadraticBezierTo(0.5 * w, 0.8 * h, 0.6 * w, 0.9 * h);
    path.quadraticBezierTo(0.7 * w, h, 0.8 * w, 0.9 * h);
    path.quadraticBezierTo(0.9 * w, 0.8 * h, w, 0.9 * h);
    path.lineTo(w, 0);
    path.close();

    //start path with this if you are making at bottom

    /* var firstStart = Offset(size.width / 5, size.height); 
      //fist point of quadratic bezier curve
      var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
      //second point of quadratic bezier curve
      path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

      var secondStart = Offset(size.width - (size.width / 3.24), size.height - 105); 
      //third point of quadratic bezier curve
      var secondEnd = Offset(size.width, size.height - 10);
      //fourth point of quadratic bezier curve
      path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

      path.lineTo(size.width, 0); //end with this path if you are making wave at bottom
      path.close();*/
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
