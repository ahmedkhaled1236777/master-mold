part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class changepassloading extends AuthState {}

class changepassfailure extends AuthState {
  final String errormessage;

  changepassfailure({required this.errormessage});
}

class changepasssuccess extends AuthState {
  final String successmessage;

  changepasssuccess({required this.successmessage});
}

class logoutloading extends AuthState {}

class logoutsuccess extends AuthState {
  final String successmessage;

  logoutsuccess({required this.successmessage});
}

class logoutfailure extends AuthState {
  final String errorrmessage;

  logoutfailure({required this.errorrmessage});
}

class signuploading extends AuthState {}

class signupsuccess extends AuthState {
  final String successmessage;

  signupsuccess({required this.successmessage});
}

class signupfailure extends AuthState {
  final String errorr_message;

  signupfailure({required this.errorr_message});
}

class signinloading extends AuthState {}

class signinsuccess extends AuthState {
  final Loginmodel loginmodel;

  signinsuccess({required this.loginmodel});
}

class signinfailure extends AuthState {
  final String errorr_message;

  signinfailure({required this.errorr_message});
}
