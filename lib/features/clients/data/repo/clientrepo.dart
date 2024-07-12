import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mastermold/core/errors/failure.dart';
import 'package:mastermold/features/clients/data/model/clientmodel/clientmodel.dart';

abstract class clientrepo {
  Future<Either<failure, String>> addclient(
      {required String name, required String phone, required String fac});
  Future<Either<failure, String>> editclient(
      {required String name,
      required String phone,
      required String fac,
      required int client_id});
  Future<Either<failure, String>> deleteclient({required int client_id});
  Future<Either<failure, Clientmodel>> getclients(
      {required int page, Map<String, dynamic>? queryparms});
}
