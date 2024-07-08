import 'package:dartz/dartz.dart';
import 'package:mastermold/core/errors/failure.dart';
import 'package:mastermold/features/auth/data/model/loginmodel/loginmodel.dart';

abstract class Authrepo {
  Future<Either<failure, String>> signup(
      {required String name,
      required String password,
      required String phone,
      required String email});
  Future<Either<failure, Loginmodel>> signin(
      {required String email, required String password, required String fcm});
}
