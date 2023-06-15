import 'package:dio/dio.dart';
import 'package:parallel/core/models/access.dart';
import 'package:parallel/core/models/company.dart';
import 'package:parallel/core/models/event.dart';
import 'package:parallel/core/models/headquarter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainRepository {
  MainRepository();

  final storage = FlutterSecureStorage();
  final String baseUrl = "http://172.16.217.133:8080/api/v1";

  Future<List<Headquarter>> getHeadquarters() async {
    List<Headquarter> headquarters = [];
    var hqResponse;

    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      hqResponse = await dio.get("$baseUrl/headquarters");

      if (hqResponse.statusCode == 200) {
        var parsedResponse =
            hqResponse.data.map((hq) => Headquarter.fromJson(hq)).toList();
        headquarters = List<Headquarter>.from(parsedResponse);
        return headquarters;
      }
    } catch (e) {
      print(e.toString());
      return headquarters;
    }
    return headquarters;
  }

  Future<List<Event>> getEvents() async {
    List<Event> events = [];
    var eResponse;

    try {
      eResponse = await Dio().get("$baseUrl/events");

      if (eResponse.statusCode == 200) {
        var parsedResponse =
            eResponse.data.map((ev) => Event.fromJson(ev)).toList();
        events = List<Event>.from(parsedResponse);
        return events;
      }
    } catch (e) {
      print(e.toString());
      return events;
    }
    return events;
  }

  Future<List<Access>> getAccessLog() async {
    List<Access> accessLog = [];
    var accessRespons;
    try {
      accessRespons = await Dio().get("$baseUrl/accesses");

      if (accessRespons.statusCode == 200) {
        var parsedResponse = accessRespons.data
            .map((access) => Access.fromJson(access))
            .toList();
        accessLog = List<Access>.from(parsedResponse);
        return accessLog;
      }
    } catch (e) {
      print(e.toString());
      return accessLog;
    }
    return accessLog;
  }

  Future<Headquarter> getHeadquarterById(int id) async {
    String? token = await storage.read(key: 'userToken');

    Headquarter headquarter = Headquarter(
      id: id,
      city: '',
      address: '',
      description: '',
      totalWorkplaces: 0,
      phoneNumber: '',
      company: Company(
        id: -1,
        name: '',
        city: '',
        address: '',
        phoneNumber: '',
        description: '',
        websiteUrl: '',
      ),
    );

    String idHq = id.toString();
    var hqResponse;

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      hqResponse = await dio.get("$baseUrl/headquarters/$idHq");

      if (hqResponse.statusCode == 200) {
        headquarter = Headquarter.fromJson(hqResponse.data);
        return headquarter;
      }
    } catch (e) {
      print(e.toString());
      return headquarter;
    }
    return headquarter;
  }

  Future<String> changePassword(
    String oldPwd,
    String newPwd,
    String confirmPwd,
    String token,
  ) async {
    ;
    var response;
    try {
      Dio dio = Dio();

      dio.options.headers['Authorization'] = 'Bearer $token';

      response = await dio.put(
        "$baseUrl/users/pwd",
        data: {
          "current": oldPwd,
          "updated": newPwd,
          "confirm": confirmPwd,
        },
      );

      if (response.statusCode == 204) {
        return "pwd_changed";
      } else {
        return "pwd_not_changed";
      }
    } catch (e) {
      print(e.toString());
    }
    return "pwd_not_changed";
  }

  Future<String> changeUserInfo(
    String city,
    String address,
    String phoneNumber,
    String token,
  ) async {
    ;
    var response;
    try {
      Dio dio = Dio();

      dio.options.headers['Authorization'] = 'Bearer $token';

      response = await dio.put(
        "$baseUrl/users",
        data: {
          "phoneNumber": phoneNumber,
          "city": city,
          "address": address,
        },
      );

      if (response.statusCode == 204) {
        return "info_changed";
      } else {
        return "info_not_changed";
      }
    } catch (e) {
      print(e.toString());
    }
    return "info_not_changed";
  }
}
