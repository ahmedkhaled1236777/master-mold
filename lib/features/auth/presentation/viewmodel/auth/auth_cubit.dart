import 'package:bloc/bloc.dart';
import 'package:mastermold/features/auth/data/model/loginmodel/loginmodel.dart';
import 'package:mastermold/features/auth/data/repos/authrepoimp.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Authrepoimp authrepoimp;
  AuthCubit(this.authrepoimp) : super(AuthInitial());
  sigup(
      {required String name,
      required String password,
      required String phone,
      required String email}) async {
    emit(signuploading());
    var result = await authrepoimp.signup(
        name: name, password: password, phone: phone, email: email);
    result.fold((failure) {
      emit(signupfailure(errorr_message: failure.error_message));
    }, (success) {
      emit(signupsuccess(successmessage: success));
    });
  }

  sigin(
      {required String email,
      required String password,
      required String fcm}) async {
    emit(signinloading());
    var result =
        await authrepoimp.signin(fcm: fcm, password: password, email: email);
    result.fold((failure) {
      emit(signinfailure(errorr_message: failure.error_message));
    }, (success) {
      emit(signinsuccess(loginmodel: success));
    });
  }
}
