import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:mastermold/core/errors/failure.dart';
import 'package:mastermold/features/auth/data/model/loginmodel/loginmodel.dart';
import 'package:mastermold/features/auth/data/model/updatemodel/updatemodel.dart';
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

  logout() async {
    emit(logoutloading());
    var result = await authrepoimp.logout();
    result.fold((failure) {
      emit(logoutfailure(errorrmessage: failure.error_message));
    }, (success) {
      emit(logoutsuccess(successmessage: success));
    });
  }

  changepass(
      {required String oldpass,
      required String newpass,
      required String cnewpass}) async {
    emit(changepassloading());
    var result = await authrepoimp.changepass(
        oldpass: oldpass, newpass: newpass, cnewpass: cnewpass);

    result.fold((failure) {
      emit(changepassfailure(errormessage: failure.error_message));
    }, (success) {
      emit(changepasssuccess(successmessage: success));
    });
  }

  updateprofile(
      {required String email,
      required String phone,
      required String name,
      File? photo}) async {
    emit(updateprofileloading());
    var result = await authrepoimp.updateprofile(
        email: email, phone: phone, name: name, photo: photo);
    result.fold((failure) {
      emit(updateprofilefailure(errormessage: failure.error_message));
    }, (success) {
      emit(updateprofilesuccess(success: success));
    });
  }
}
