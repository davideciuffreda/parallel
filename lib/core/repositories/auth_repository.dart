// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:dio/dio.dart';
import 'package:parallel/core/models/user/user.dart';

///AuthRepository gestisce le richieste di autenticazione e la memoria locale
///con le librerire SharedPreferences e FlutterSecureStorage
class AuthRepository {
  AuthRepository();

  final String baseUrl = "http://172.16.219.94:8080/api/v1";

  ///tryLogIn esegue il login, se viene completato con successo.
  ///INPUT: email, password
  ///OUTPUT: token
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

  ///getUserInfo a partire dal token ottiene i dati completi dell'utente
  ///loggato.
  ///INPUT: token
  ///OUTPUT: oggetto User
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

  ///tryLogOut a partire dal token esegue il logout dell'utente loggato.
  ///INPUT: token
  ///OUTPUT: -
  Future<void> tryLogOut(String token) async {
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.get("$baseUrl/auth/logout");
    } catch (e) {
      print("Exception -> " + e.toString());
    }
  }
}
