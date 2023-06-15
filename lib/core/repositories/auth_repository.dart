import 'package:dio/dio.dart';
import 'package:parallel/core/models/user.dart';

class AuthRepository {
  AuthRepository();

  final String baseUrl = "http://192.168.99.225:8080/api/v1";

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
      } else if (response.statusCode == 401) {
        return token = "401";
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
    return token;
  }

  Future<User> getUserInfo(String token) async {
    User currentUser = User(
      id: -1,
      firstName: "",
      lastName: "",
      email: "",
      birthDate: DateTime(0),
      phoneNumber: "",
      city: "",
      address: "",
      role: "",
      scopeId: 0,
      jobPosition: "",
    );
    var response;
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.get("$baseUrl/users/who-am-i");

      if (response.statusCode == 200) {
        currentUser = User.fromJson(response.data);
        return currentUser;
      }
    } catch (e) {
      print("Exception -> " + e.toString());
    }
    return currentUser;
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
