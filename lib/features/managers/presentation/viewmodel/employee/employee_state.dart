part of 'employee_cubit.dart';

abstract class EmployeeStatemanager {}

class EmployeemanagerInitial extends EmployeeStatemanager {}

class changetypemanagerstate extends EmployeeStatemanager {}

class editemployeemanagerloading extends EmployeeStatemanager {}

class editemployeemanagersuccess extends EmployeeStatemanager {
  final String successmessage;

  editemployeemanagersuccess({required this.successmessage});
}

class editemployeemanagerfailure extends EmployeeStatemanager {
  final String errorrmessage;

  editemployeemanagerfailure({required this.errorrmessage});
}

class employeemanagerloading extends EmployeeStatemanager {}

class employeemanagerssuccess extends EmployeeStatemanager {
  final String successmessage;

  employeemanagerssuccess({required this.successmessage});
}

class employeemanagerfailure extends EmployeeStatemanager {
  final String errorrmessage;

  employeemanagerfailure({required this.errorrmessage});
}
