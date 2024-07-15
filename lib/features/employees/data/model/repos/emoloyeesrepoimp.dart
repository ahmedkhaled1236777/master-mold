import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mastermold/core/commn/sharedpref/cashhelper.dart';
import 'package:mastermold/core/errors/failure.dart';
import 'package:mastermold/core/errors/handlingerror.dart';
import 'package:mastermold/core/services/apiservice.dart';
import 'package:mastermold/core/urls/urls.dart';
import 'package:mastermold/features/employees/data/model/employeemodel/employeemodel.dart';
import 'package:mastermold/features/employees/data/model/repos/employessrepo.dart';

class Emoloyeesrepoimp extends Employessrepo {
  @override
  Future<Either<failure, Employeemodel>> getemployeess() async {
    try {
      Response response = await Getdata.getdata(
          path: urls.employers, token: cashhelper.getdata(key: "token"));
      if (response.data["status"] == true && response.statusCode == 200) {
        return right(Employeemodel.fromJson(response.data));
      } else {
        if (response.data["data"] != null) {
          return left(requestfailure(error_message: response.data["data"][0]));
        } else
          return left(requestfailure(error_message: response.data["error"]));
      }
    } catch (e) {
      if (e is DioException)
        return left(requestfailure.fromdioexception(e));
      else
        return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editemployee(
      {required int id, required String status}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.is_active,
          token: cashhelper.getdata(key: "token"),
          queryParameters: {"is_active": status, "user_id": id});
      if (response.data["status"] == true && response.statusCode == 200) {
        return right("تم تعديل البيانات بنجاح");
      } else {
        if (response.data["data"] != null) {
          return left(requestfailure(error_message: response.data["data"][0]));
        } else
          return left(requestfailure(error_message: response.data["error"]));
      }
    } catch (e) {
      if (e is DioException)
        return left(requestfailure.fromdioexception(e));
      else
        return left(requestfailure(error_message: e.toString()));
    }
  }
}
