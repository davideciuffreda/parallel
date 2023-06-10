import 'package:dio/dio.dart';

class AuthRepository {
  AuthRepository();

  final String baseUrl = "http://172.16.217.84:8080/api/v1";

  Future<String> tryLogIn(String email, String password) async {
    String token = "";
    var response;
    try {
      response = await Dio().post(
        "$baseUrl/auth",
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        token = response.data['token'];
        return token;
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
    return token;
  }

  Future<void> tryLogOut(String token) async {
    var response;
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.get("$baseUrl/auth/logout");
    } catch (e) {
      print("Exception -> " + e.toString());
    }
  }
}
