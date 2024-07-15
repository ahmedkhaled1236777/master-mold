import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/commn/loading.dart';
import 'package:mastermold/core/commn/showdialogerror.dart';
import 'package:mastermold/core/commn/toast/toast.dart';
import 'package:mastermold/core/commn/widgets/custommaterialbutton.dart';
import 'package:mastermold/features/employees/presentation/viewmodel/employee/employee_cubit.dart';
import 'package:mastermold/features/employees/presentation/views/widgets/radios.dart';

class Editcontent extends StatelessWidget {
  final int id;

  const Editcontent({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: IntrinsicHeight(
        child: Column(
          children: [
            BlocBuilder<EmployeeCubit, EmployeeState>(
              builder: (context, state) {
                return employeeradios(
                  firstradio: "yes",
                  secondradio: "no",
                  firstradiotitle: "مفعل",
                  secondradiotitle: "غير مفعل",
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            BlocConsumer<EmployeeCubit, EmployeeState>(
              listener: (context, state) async {
                if (state is editemployeefailure) {
                  showdialogerror(error: state.errorrmessage, context: context);
                }
                if (state is editemployeesuccess) {
                  await BlocProvider.of<EmployeeCubit>(context).getemployeess();
                  showtoast(
                      message: state.successmessage,
                      toaststate: Toaststate.succes);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is editemployeeloading) return loading();
                return custommaterialbutton(
                  button_name: "تعديل",
                  onPressed: () async {
                    await BlocProvider.of<EmployeeCubit>(context).editemployee(
                        id: id,
                        status: BlocProvider.of<EmployeeCubit>(context).type!);
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
