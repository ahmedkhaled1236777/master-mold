import 'package:dartz/dartz.dart';
import 'package:mastermold/core/errors/failure.dart';
import 'package:mastermold/features/actions/data/model/actionmodel/actionmodel.dart';
import 'package:mastermold/features/actions/data/model/actionmodelrequest.dart';

abstract class Actionrepo {
  Future<Either<failure, String>> addaction(
      {required Actionmodelrequest actionmodelrequest});
  Future<Either<failure, String>> editaction(
      {required int actionid, required Actionmodelrequest actionmodelrequest});
  Future<Either<failure, String>> deleteaction({required int action_id});
  Future<Either<failure, Actionmodel>> getactions(
      {required int page,
      Map<String, dynamic>? queryparms,
      required int client_id});
}
