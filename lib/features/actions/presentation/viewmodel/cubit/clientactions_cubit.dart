import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mastermold/features/actions/data/model/actionmodel/datum.dart';
import 'package:mastermold/features/actions/data/model/actionmodelrequest.dart';
import 'package:mastermold/features/actions/data/repo/actionrepoimp.dart';

part 'clientactions_state.dart';

class ClientactionsCubit extends Cubit<ClientactionsState> {
  final Actionrepoimp actionrepoimp;
  ClientactionsCubit(this.actionrepoimp) : super(ClientactionsInitial());
  int page = 1;
  String type = "maintenance";

  bool loading = false;
  List<Datum> data = [];
  bool firstloading = false;
  Map<String, dynamic>? queryparms;
  int maintenance = 0;
  int payment = 0;
  List<bool> checks = [];
  getactions({required int client_id}) async {
    if (firstloading == false) emit(Clientactionsloading());
    checks.clear();
    this.page = 1;
    payment = 0;
    maintenance = 0;
    var result = await actionrepoimp.getactions(
        page: page, client_id: client_id, queryparms: queryparms);
    loading = true;
    result.fold((failue) {
      emit(Clientactionsfailurre(errormessage: failue.error_message));
    }, (success) {
      if (success.actions!.nextPageUrl == null) {
        loading = false;
      }
      data.clear();
      firstloading = true;
      success.actions!.data!.forEach((e) {
        data.add(e);
        checks.add(false);
      });
      maintenance = success.totalMaintenance!;
      payment = success.totalPayment!;
      emit(Clientactionssuccess(successmessage: ""));
    });
  }

  getamoreclients({required int client_id}) async {
    print("pppppppppppppppppppppppppppppppppppppppppppppp");
    page++;
    print("ooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    var result = await actionrepoimp.getactions(
        page: page, client_id: client_id, queryparms: queryparms);
    loading = true;
    result.fold((failue) {
      emit(Clientactionsfailurre(errormessage: failue.error_message));
    }, (success) {
      if (success.actions!.nextPageUrl == null) {
        loading = false;
      }
      success.actions!.data!.forEach((e) {
        data.add(e);
        checks.add(false);
      });
      emit(Clientactionssuccess(successmessage: ""));
    });
  }

  deleteaction({required int actionid}) async {
    emit(deleteactionloading());
    var result = await actionrepoimp.deleteaction(
      action_id: actionid,
    );
    result.fold((failure) {
      emit(deleteactionfailure(errormessage: failure.error_message));
    }, (success) {
      data.removeWhere((e) {
        return e.id == actionid;
      });
      emit(deleteactionsuccess(successmessage: success));
    });
  }

  changecheckbox(bool val, int i) {
    checks[i] = val;
    emit(changecheck());
  }

  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }

  addaction({required Actionmodelrequest actiomodelrequest}) async {
    emit(addactionloading());
    var result =
        await actionrepoimp.addaction(actionmodelrequest: actiomodelrequest);
    result.fold((failure) {
      emit(addactionfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addactionsuccess(successmessage: success));
    });
  }
}
