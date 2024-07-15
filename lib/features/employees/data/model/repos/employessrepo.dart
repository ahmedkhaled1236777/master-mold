import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:mastermold/core/errors/failure.dart';
import 'package:mastermold/features/employees/data/model/employeemodel/employeemodel.dart';

abstract class Employessrepo {
  Future<Either<failure, Employeemodel>> getemployeess();
  Future<Either<failure, String>> editemployee(
      {required int id, required String status});
}
