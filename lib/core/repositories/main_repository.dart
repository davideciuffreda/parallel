import 'package:dio/dio.dart';
import 'package:parallel/core/models/access.dart';
import 'package:parallel/core/models/event.dart';
import 'package:parallel/core/models/headquarter.dart';

class MainRepository {
  MainRepository();

  final String baseUrl = "http://172.16.217.236:3000";

  Future<List<Headquarter>> getHeadquarters() async {
    List<Headquarter> headquarters = [];
    var hqResponse;
    try {
      hqResponse = await Dio().get("$baseUrl/hq");

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
        var parsedResponse =
            accessRespons.data.map((access) => Access.fromJson(access)).toList();
        accessLog = List<Access>.from(parsedResponse);
        return accessLog;
      }
    } catch (e) {
      print(e.toString());
      return accessLog;
    }
    return accessLog;
  }
}
