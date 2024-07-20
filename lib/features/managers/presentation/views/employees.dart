import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/constants.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/shimmer/shimmer.dart';

import 'package:mastermold/core/commn/widgets/headerwidget.dart';
import 'package:mastermold/core/commn/widgets/nodata.dart';

import 'package:mastermold/features/employees/presentation/views/widgets/employeeitem.dart';
import 'package:mastermold/features/managers/presentation/viewmodel/employee/employee_cubit.dart';
import 'package:mastermold/features/managers/presentation/views/widgets/editcontent.dart';

class managers extends StatefulWidget {
  @override
  State<managers> createState() => _managersState();
}

class _managersState extends State<managers> {
  final employeesheader = [
    "اسم الموظف",
    "رقم الهاتف",
    "الحاله",
    "تعديل",
  ];

  getdata() async {
    BlocProvider.of<EmployeeCubitmanager>(context).firsttime = false;
    BlocProvider.of<EmployeeCubitmanager>(context).getemployeess();
  }

  @override
  void initState() {
    getdata();
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
                "الموظفين",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(children: [
              Container(
                height: 50,
                color: Appcolors.dropcolor,
                child: Row(
                    children: employeesheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(child:
                  BlocBuilder<EmployeeCubitmanager, EmployeeStatemanager>(
                builder: (context, state) {
                  if (state is employeemanagerloading) return loadingshimmer();
                  if (state is employeemanagerfailure) return SizedBox();
                  return BlocProvider.of<EmployeeCubitmanager>(context)
                          .employee
                          .isEmpty
                      ? nodata()
                      : ListView.separated(
                          itemBuilder: (context, i) => BlocProvider.of<
                                          EmployeeCubitmanager>(context)
                                      .employee[i]
                                      .id !=
                                  46
                              ? customtableemployeeitem(
                                  employeename:
                                      BlocProvider.of<EmployeeCubitmanager>(context)
                                          .employee[i]
                                          .name!,
                                  phone:
                                      BlocProvider.of<EmployeeCubitmanager>(context)
                                          .employee[i]
                                          .phone!,
                                  status:
                                      BlocProvider.of<EmployeeCubitmanager>(context)
                                                  .employee[i]
                                                  .isActive ==
                                              "yes"
                                          ? "مفعل"
                                          : "غير مفعل",
                                  edit: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0)),
                                                  title: Container(
                                                    height: 20,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: Appcolors
                                                              .maincolor,
                                                        )),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  backgroundColor: Colors.white,
                                                  insetPadding:
                                                      EdgeInsets.all(35),
                                                  content: Editcontentmanager(
                                                      id: BlocProvider.of<
                                                                  EmployeeCubitmanager>(
                                                              context)
                                                          .employee[i]
                                                          .id!));
                                            });
                                      },
                                      icon: Icon(editeicon)))
                              : SizedBox(),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount:
                              BlocProvider.of<EmployeeCubitmanager>(context)
                                  .employee
                                  .length);
                },
              ))
            ])));
  }
}
