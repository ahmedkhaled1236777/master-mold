part of 'employee_cubit.dart';

abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class changetypestate extends EmployeeState {}

class editemployeeloading extends EmployeeState {}

class editemployeesuccess extends EmployeeState {
  final String successmessage;

  editemployeesuccess({required this.successmessage});
}

class editemployeefailure extends EmployeeState {
  final String errorrmessage;

  editemployeefailure({required this.errorrmessage});
}

class employeeloading extends EmployeeState {}

class employeessuccess extends EmployeeState {
  final String successmessage;

  employeessuccess({required this.successmessage});
}

class employeefailure extends EmployeeState {
  final String errorrmessage;

  employeefailure({required this.errorrmessage});
}
