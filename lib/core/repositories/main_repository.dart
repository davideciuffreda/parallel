import 'package:dio/dio.dart';
import 'package:parallel/core/models/access.dart';
import 'package:parallel/core/models/company.dart';
import 'package:parallel/core/models/event.dart';
import 'package:parallel/core/models/headquarter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parallel/core/models/workplace.dart';
import 'package:parallel/core/models/workspace.dart';

class MainRepository {
  MainRepository();

  final storage = FlutterSecureStorage();
  final String baseUrl = "http://172.16.218.232:8080/api/v1";

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

  Future<List<Workspace>> getWorkspacesByDate(
      int hqId, String bookingDate) async {
    List<Workspace> workspaces = [];
    var wResponse;

    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      wResponse = await dio.get(
          "$baseUrl/headquarters/$hqId/workspaces?bookingDate=$bookingDate");

      if (wResponse.statusCode == 200) {
        var parsedResponse = wResponse.data
            .map((workspace) => Workspace.fromJson(workspace))
            .toList();
        workspaces = List<Workspace>.from(parsedResponse);
        return workspaces;
      }
    } catch (e) {
      print(e.toString());
      return workspaces;
    }
    return workspaces;
  }

  Future<List<Workplace>> getWorkplacesByWorkspace(
      int hqId, int wsId) async {
    List<Workplace> workplaces = [];
    var wResponse;

    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      wResponse = await dio.get(
          "$baseUrl/headquarters/$hqId/workspaces/$wsId/workplaces");

      if (wResponse.statusCode == 200) {
        var parsedResponse = wResponse.data
            .map((workplace) => Workplace.fromJson(workplace))
            .toList();
        workplaces = List<Workplace>.from(parsedResponse);
        return workplaces;
      }
    } catch (e) {
      print(e.toString());
      return workplaces;
    }
    return workplaces;
  }

  Future<int> setFavoriteHeadquarter(int hqId) async {
    var response;
    String? token = await storage.read(key: 'userToken');
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.patch("$baseUrl/headquarters/favs/$hqId");

      //print("[StatusCode] " + response.statusCode.toString());

      return response.statusCode;
    } catch (e) {
      print(e.toString());
    }
    return 0;
  }

  Future<Event?> createNewEvent(
    int id,
    String name,
    String eventDate,
    String startTime,
    String endTime,
    int maxPlaces,
  ) async {
    Event? newEvent;
    var response;
    String? token = await storage.read(key: 'userToken');

    /* print("[Token] " + token.toString());
    print("[ID] " + id.toString());
    print("[Name] " + name);
    print("[EventDate] " + eventDate);
    print("[startTime] " + startTime);
    print("[endTime] " + endTime);
    print("[maxPlaces] " + maxPlaces.toString()); */

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.post(
        "$baseUrl/headquarters/$id/events",
        data: {
          "name": name,
          "eventDate": eventDate,
          "startTime": startTime,
          "endTime": endTime,
          "maxPlaces": maxPlaces,
        },
      );

      print("Response " + response.statusCode);

      if (response.statusCode == 201) {
        print("[Response]: " + response);
        newEvent = response.data.map((event) => Event.fromJson(event));
        return newEvent;
      } else if (response.statusCode == 403) {
        response.data;
      }
    } catch (e) {
      print(e.toString());
      return newEvent;
    }
    return newEvent;
  }

  Future<List<Event>> getEvents() async {
    List<Event> events = [];
    var eResponse;

    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      eResponse = await dio.get("$baseUrl/events");

      if (eResponse.statusCode == 200) {
        var parsedResponse =
            eResponse.data.map((ev) => Event.fromJson(ev)).toList();
        events = List<Event>.from(parsedResponse);
        return events;
      }
    } catch (e) {
      print("Exception: " + e.toString());
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
      favorite: false,
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
