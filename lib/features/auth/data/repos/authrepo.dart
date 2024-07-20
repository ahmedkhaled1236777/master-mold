import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mastermold/core/errors/failure.dart';
import 'package:mastermold/features/auth/data/model/loginmodel/loginmodel.dart';
import 'package:mastermold/features/auth/data/model/updatemodel/updatemodel.dart';

abstract class Authrepo {
  Future<Either<failure, String>> signup(
      {required String name,
      required String password,
      required String phone,
      required String email});
  Future<Either<failure, Loginmodel>> signin(
      {required String email, required String password, required String fcm});
  Future<Either<failure, String>> logout();
  Future<Either<failure, Updatemodel>> updateprofile(
      {required String email,
      required String phone,
      required String name,
      File? photo});
  Future<Either<failure, String>> changepass(
      {required String oldpass,
      required String newpass,
      required String cnewpass});
}
