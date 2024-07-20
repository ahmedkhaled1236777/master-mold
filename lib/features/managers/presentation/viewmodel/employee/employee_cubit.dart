import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mastermold/features/employees/data/model/employeemodel/employer.dart';
import 'package:mastermold/features/employees/data/model/repos/emoloyeesrepoimp.dart';
import 'package:mastermold/features/managers/data/model/repos/emoloyeesrepoimp.dart';

part 'employee_state.dart';

class EmployeeCubitmanager extends Cubit<EmployeeStatemanager> {
  bool firsttime = false;
  final Emoloyeesrepoimpmangaer emoloyeesrepoimp;
  String? type;
  List<Employer> employee = [];
  EmployeeCubitmanager(this.emoloyeesrepoimp) : super(EmployeemanagerInitial());
  getemployeess() async {
    if (firsttime == false) emit(employeemanagerloading());
    var result = await emoloyeesrepoimp.getemployeess();
    result.fold((failure) {
      emit(employeemanagerfailure(errorrmessage: failure.error_message));
    }, (success) {
      firsttime = true;
      employee = success.employers!;
      emit(employeemanagerssuccess(successmessage: ""));
    });
  }

  editemployee({required int id, required String status}) async {
    emit(editemployeemanagerloading());
    var result = await emoloyeesrepoimp.editmanager(id: id, status: status);
    result.fold((failure) {
      emit(editemployeemanagerfailure(errorrmessage: failure.error_message));
    }, (success) {
      emit(editemployeemanagersuccess(successmessage: success));
    });
  }

  changetype({required String value}) {
    type = value;
    emit(changetypemanagerstate());
  }
}
