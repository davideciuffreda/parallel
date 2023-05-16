import 'dart:convert';
import 'package:dio/dio.dart';
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
}
