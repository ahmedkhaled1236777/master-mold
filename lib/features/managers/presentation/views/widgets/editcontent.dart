import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/showdialogerror.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/features/managers/presentation/viewmodel/employee/employee_cubit.dart';
import 'package:mastermold/features/managers/presentation/views/widgets/radios.dart';

class Editcontentmanager extends StatelessWidget {
  final int id;

  const Editcontentmanager({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: IntrinsicHeight(
        child: Column(
          children: [
            BlocBuilder<EmployeeCubitmanager, EmployeeStatemanager>(
              builder: (context, state) {
                return employeeradiosmanager(
                  firstradio: "yes",
                  secondradio: "no",
                  firstradiotitle: "مدير",
                  secondradiotitle: "غير مدير",
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            BlocConsumer<EmployeeCubitmanager, EmployeeStatemanager>(
              listener: (context, state) async {
                if (state is editemployeemanagerfailure) {
                  showdialogerror(error: state.errorrmessage, context: context);
                }
                if (state is editemployeemanagersuccess) {
                  await BlocProvider.of<EmployeeCubitmanager>(context)
                      .getemployeess();
                  showtoast(
                      message: state.successmessage,
                      toaststate: Toaststate.succes);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is editemployeemanagerloading) return loading();
                return custommaterialbutton(
                  button_name: "تعديل",
                  onPressed: () async {
                    if (BlocProvider.of<EmployeeCubitmanager>(context).type !=
                        null)
                      await BlocProvider.of<EmployeeCubitmanager>(context)
                          .editemployee(
                              id: id,
                              status:
                                  BlocProvider.of<EmployeeCubitmanager>(context)
                                      .type!);
                  },
                );
              },
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
