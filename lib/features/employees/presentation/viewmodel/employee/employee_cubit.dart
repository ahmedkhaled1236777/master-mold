import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mastermold/features/employees/data/model/employeemodel/employer.dart';
import 'package:mastermold/features/employees/data/model/repos/emoloyeesrepoimp.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  bool firsttime = false;
  final Emoloyeesrepoimp emoloyeesrepoimp;
  String? type;
  List<Employer> employee = [];
  EmployeeCubit(this.emoloyeesrepoimp) : super(EmployeeInitial());
  getemployeess() async {
    if (firsttime == false) emit(employeeloading());
    var result = await emoloyeesrepoimp.getemployeess();
    result.fold((failure) {
      emit(employeefailure(errorrmessage: failure.error_message));
    }, (success) {
      firsttime = true;
      employee = success.employers!;
      emit(employeessuccess(successmessage: ""));
    });
  }

  editemployee({required int id, required String status}) async {
    emit(editemployeeloading());
    var result = await emoloyeesrepoimp.editemployee(id: id, status: status);
    result.fold((failure) {
      emit(editemployeefailure(errorrmessage: failure.error_message));
    }, (success) {
      emit(editemployeesuccess(successmessage: success));
    });
  }

  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }
}
