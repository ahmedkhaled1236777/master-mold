part of 'clientactions_cubit.dart';

abstract class ClientactionsState {}

class ClientactionsInitial extends ClientactionsState {}

class changetypestate extends ClientactionsState {}

class addactionloading extends ClientactionsState {}

class addactionsuccess extends ClientactionsState {
  final String successmessage;

  addactionsuccess({required this.successmessage});
}

class addactionfailure extends ClientactionsState {
  final String errormessage;

  addactionfailure({required this.errormessage});
}

class changecheck extends ClientactionsState {}

class deleteactionloading extends ClientactionsState {}

class deleteactionsuccess extends ClientactionsState {
  final String successmessage;

  deleteactionsuccess({required this.successmessage});
}

class deleteactionfailure extends ClientactionsState {
  final String errormessage;

  deleteactionfailure({required this.errormessage});
}

class Clientactionsloading extends ClientactionsState {}

class Clientactionssuccess extends ClientactionsState {
  final String successmessage;

  Clientactionssuccess({required this.successmessage});
}

class Clientactionsfailurre extends ClientactionsState {
  final String errormessage;

  Clientactionsfailurre({required this.errormessage});
}
