import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mastermold/core/errors/failure.dart';
import 'package:mastermold/core/errors/handlingerror.dart';
import 'package:mastermold/core/services/apiservice.dart';
import 'package:mastermold/core/urls/urls.dart';
import 'package:mastermold/features/auth/data/model/loginmodel/loginmodel.dart';
import 'package:mastermold/features/auth/data/repos/authrepo.dart';

class Authrepoimp extends Authrepo {
  @override
  Future<Either<failure, String>> signup(
      {required String name,
      required String password,
      required String phone,
      required String email}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.register,
          queryParameters: {
            "name": name,
            "email": email,
            "phone": phone,
            "password": password
          });
      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(
            "تم تسجيل الدخول بنجاح برجاء التواصل مع المدير لتفعيل الحساب");
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
  Future<Either<failure, Loginmodel>> signin(
      {required String email,
      required String password,
      required String fcm}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.login,
          queryParameters: {
            "login": email,
            "password": password,
            "fcm_token": fcm
          });
      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Loginmodel.fromJson(response.data));
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
