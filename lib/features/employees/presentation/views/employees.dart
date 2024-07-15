import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/color/appcolors.dart';
import 'package:mastermold/core/commn/constants.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/shimmer/shimmer.dart';
import 'package:mastermold/core/commn/showdialogerror.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/core/commn/widgets/headerwidget.dart';
import 'package:mastermold/core/commn/widgets/nodata.dart';
import 'package:mastermold/features/employees/presentation/viewmodel/employee/employee_cubit.dart';
import 'package:mastermold/features/employees/presentation/views/widgets/editcontent.dart';
import 'package:mastermold/features/employees/presentation/views/widgets/employeeitem.dart';
import 'package:mastermold/features/employees/presentation/views/widgets/radios.dart';

class employees extends StatefulWidget {
  @override
  State<employees> createState() => _employeesState();
}

class _employeesState extends State<employees> {
  final employeesheader = [
    "اسم الموظف",
    "رقم الهاتف",
    "الحاله",
    "تعديل",
  ];

  getdata() async {
    BlocProvider.of<EmployeeCubit>(context).firsttime = false;
    BlocProvider.of<EmployeeCubit>(context).getemployeess();
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
              Expanded(child: BlocBuilder<EmployeeCubit, EmployeeState>(
                builder: (context, state) {
                  if (state is employeeloading) return loadingshimmer();
                  if (state is employeefailure) return SizedBox();
                  return BlocProvider.of<EmployeeCubit>(context)
                          .employee
                          .isEmpty
                      ? nodata()
                      : ListView.separated(
                          itemBuilder: (context, i) => customtableemployeeitem(
                              employeename:
                                  BlocProvider.of<EmployeeCubit>(context)
                                      .employee[i]
                                      .name!,
                              phone: BlocProvider.of<EmployeeCubit>(context)
                                  .employee[i]
                                  .phone!,
                              status: BlocProvider.of<EmployeeCubit>(context)
                                          .employee[i]
                                          .isActive ==
                                      "yes"
                                  ? "مفعل"
                                  : "غير مفعل",
                              edit: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<EmployeeCubit>(context)
                                            .type =
                                        BlocProvider.of<EmployeeCubit>(context)
                                            .employee[i]
                                            .isActive!;
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0)),
                                              title: Container(
                                                height: 20,
                                                alignment: Alignment.topLeft,
                                                child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color:
                                                          Appcolors.maincolor,
                                                    )),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              backgroundColor: Colors.white,
                                              insetPadding: EdgeInsets.all(35),
                                              content: Editcontent(
                                                  id: BlocProvider.of<
                                                              EmployeeCubit>(
                                                          context)
                                                      .employee[i]
                                                      .id!));
                                        });
                                  },
                                  icon: Icon(editeicon))),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<EmployeeCubit>(context)
                              .employee
                              .length);
                },
              ))
            ])));
  }
}
