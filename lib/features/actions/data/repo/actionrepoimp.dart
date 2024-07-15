import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mastermold/core/commn/sharedpref/cashhelper.dart';
import 'package:mastermold/core/errors/failure.dart';
import 'package:mastermold/core/errors/handlingerror.dart';
import 'package:mastermold/core/services/apiservice.dart';
import 'package:mastermold/core/urls/urls.dart';
import 'package:mastermold/features/actions/data/model/actionmodel/actionmodel.dart';
import 'package:mastermold/features/actions/data/model/actionmodelrequest.dart';
import 'package:mastermold/features/actions/data/repo/actionrepo.dart';

class Actionrepoimp extends Actionrepo {
  @override
  Future<Either<failure, String>> deleteaction({required int action_id}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.deleteaction,
          queryParameters: {"action_id": action_id});

      if (response.data["status"] == true && response.statusCode == 200) {
        return right("تم الحذف بنجاح");
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
  Future<Either<failure, Actionmodel>> getactions(
      {required int page,
      Map<String, dynamic>? queryparms,
      required int client_id}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: "get_client_actions?page=${page}&client_id=${client_id}",
          queryParameters: queryparms);

      if (response.data["status"] == true && response.statusCode == 200) {
        return right(Actionmodel.fromJson(response.data));
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
  Future<Either<failure, String>> addaction(
      {required Actionmodelrequest actionmodelrequest}) async {
    try {
      Response response = await Postdata.postdata(
        data: actionmodelrequest.tojson(),
        token: cashhelper.getdata(key: "token"),
        path: urls.addaction,
      );

      if (response.data["status"] == true && response.statusCode == 200) {
        return right("تم الاضافه بنجاح");
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
  Future<Either<failure, String>> editaction(
      {required int actionid,
      required Actionmodelrequest actionmodelrequest}) async {
    try {
      Response response = await Postdata.postdata(
        data: actionmodelrequest.tojson(),
        token: cashhelper.getdata(key: "token"),
        path: "update_action/${actionid}",
      );

      if (response.data["status"] == true && response.statusCode == 200) {
        return right("تم التعديل بنجاح");
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
