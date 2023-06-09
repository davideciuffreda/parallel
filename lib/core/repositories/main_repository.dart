import 'package:dio/dio.dart';
import 'package:parallel/core/models/access.dart';
import 'package:parallel/core/models/event.dart';
import 'package:parallel/core/models/headquarter.dart';

class MainRepository {
  MainRepository();

  final String baseUrl = "http://172.16.217.84:8080/api/v1";

  Future<List<Headquarter>> getHeadquarters() async {
    List<Headquarter> headquarters = [];
    var hqResponse;
    try {
      hqResponse = await Dio().get("$baseUrl/headquarters");

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
    var eRespons;
    try {
      eRespons = await Dio().get("$baseUrl/events");

      if (eRespons.statusCode == 200) {
        var parsedResponse =
            eRespons.data.map((ev) => Event.fromJson(ev)).toList();
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
    Headquarter headquarter = Headquarter(
      id: -1,
      imageUrl: "",
      name: "",
      city: "",
      workstations: -1,
      address: "",
      description: "",
    );
    String idHq = id.toString();
    var hqRespons;

    try {
      hqRespons = await Dio().get("$baseUrl/hq?id=$idHq");

      if (hqRespons.statusCode == 200) {
        headquarter = Headquarter.fromJson(hqRespons.data[0]);
        return headquarter;
      }
    } catch (e) {
      print(e.toString());
      return headquarter;
    }
    return headquarter;
  }
}
