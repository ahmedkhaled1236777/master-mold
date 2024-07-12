import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mastermold/core/commn/sharedpref/cashhelper.dart';
import 'package:mastermold/core/errors/failure.dart';
import 'package:mastermold/core/errors/handlingerror.dart';
import 'package:mastermold/core/services/apiservice.dart';
import 'package:mastermold/core/urls/urls.dart';
import 'package:mastermold/features/clients/data/model/clientmodel/clientmodel.dart';
import 'package:mastermold/features/clients/data/repo/clientrepo.dart';

class Clientrepoimp extends clientrepo {
  @override
  Future<Either<failure, String>> addclient(
      {required String name,
      required String phone,
      required String fac}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.addclient,
          queryParameters: {"name": name, "phone": phone, "industry": fac});

      if (response.data["status"] == true && response.statusCode == 200) {
        return right("تم تسجيل العميل بنجاح");
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
  Future<Either<failure, Clientmodel>> getclients(
      {required int page, Map<String, dynamic>? queryparms}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: "get_clients?page=${page}",
          queryParameters: queryparms);

      if (response.data["status"] == true && response.statusCode == 200) {
        return right(Clientmodel.fromJson(response.data));
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
  Future<Either<failure, String>> deleteclient({required int client_id}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.deleteclient,
          queryParameters: {"client_id": client_id});

      if (response.data["status"] == true && response.statusCode == 200) {
        return right("تم حذف العميل بنجاح");
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
  Future<Either<failure, String>> editclient(
      {required String name,
      required String phone,
      required String fac,
      required int client_id}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.editclient,
          queryParameters: {
            "clientId": client_id,
            "name": name,
            "phone": phone,
            "industry": fac
          });

      if (response.data["status"] == true && response.statusCode == 200) {
        return right("تم تعديل بيانات العميل بنجاح");
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
