part of 'client_cubit.dart';

abstract class ClientState {}

class ClientInitial extends ClientState {}

class editclientloading extends ClientState {}

class editclientsuccess extends ClientState {
  final String success_message;

  editclientsuccess({required this.success_message});
}

class editclientfailure extends ClientState {
  final String errorrmessage;

  editclientfailure({required this.errorrmessage});
}

class getclientsloading extends ClientState {}

class deleteclientsloading extends ClientState {}

class deleteclientssuccess extends ClientState {
  final String success_message;

  deleteclientssuccess({required this.success_message});
}

class deleteclientsfailure extends ClientState {
  final String error_message;

  deleteclientsfailure({required this.error_message});
}

class getclientssuccess extends ClientState {
  final String success_message;

  getclientssuccess({required this.success_message});
}

class getclientsfailure extends ClientState {
  final String error_message;

  getclientsfailure({required this.error_message});
}

class addClientloadind extends ClientState {}

class addCliensuccess extends ClientState {
  final String successmessage;

  addCliensuccess({required this.successmessage});
}

class addClientfailure extends ClientState {
  final String errorr_message;

  addClientfailure({required this.errorr_message});
}
