import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mastermold/features/clients/data/model/clientmodel/datum.dart';
import 'package:mastermold/features/clients/data/repo/clientrepoimp.dart';

part 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  final Clientrepoimp clientrepoimp;
  ClientCubit(this.clientrepoimp) : super(ClientInitial());
  int page = 1;
  bool loading = false;
  List<Datum> data = [];
  bool firstloading = false;
  Map<String, dynamic>? queryparms;
  addclient(
      {required String name,
      required String phone,
      required String fac}) async {
    emit(addClientloadind());
    var result =
        await clientrepoimp.addclient(name: name, phone: phone, fac: fac);
    result.fold((failure) {
      emit(addClientfailure(errorr_message: failure.error_message));
    }, (success) {
      emit(addCliensuccess(successmessage: success));
    });
  }

  editclient(
      {required String name,
      required int client_id,
      required String phone,
      required String fac}) async {
    emit(editclientloading());
    var result = await clientrepoimp.editclient(
        name: name, phone: phone, fac: fac, client_id: client_id);
    result.fold((failure) {
      emit(editclientfailure(errorrmessage: failure.error_message));
    }, (success) {
      emit(editclientsuccess(success_message: success));
    });
  }

  getclients({required int page}) async {
    if (firstloading == false) emit(getclientsloading());
    this.page = 1;
    var result =
        await clientrepoimp.getclients(page: page, queryparms: queryparms);
    loading = true;
    result.fold((failue) {
      emit(getclientsfailure(error_message: failue.error_message));
    }, (success) {
      if (success.clients!.nextPageUrl == null) {
        loading = false;
      }
      data.clear();
      firstloading = true;
      data.addAll(success.clients!.data!);
      emit(getclientssuccess(success_message: ""));
    });
  }

  getamoreclients() async {
    page++;
    var result =
        await clientrepoimp.getclients(page: page, queryparms: queryparms);
    loading = true;
    result.fold((failue) {
      emit(getclientsfailure(error_message: failue.error_message));
    }, (success) {
      if (success.clients!.nextPageUrl == null) {
        loading = false;
      }
      data.addAll(success.clients!.data!);
      emit(getclientssuccess(success_message: ""));
    });
  }

  deleteclient({required int client_id}) async {
    emit(deleteclientsloading());
    var result = await clientrepoimp.deleteclient(
      client_id: client_id,
    );
    result.fold((failure) {
      emit(deleteclientsfailure(error_message: failure.error_message));
    }, (success) {
      data.removeWhere((e) {
        return e.id == client_id;
      });
      emit(deleteclientssuccess(success_message: success));
    });
  }
}
