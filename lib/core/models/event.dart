// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  int id;
  CompanyEvent company;
  HeadquartersEvent headquarters;
  String name;
  DateTime eventDate;
  String startTime;
  String endTime;
  int availablePlaces;
  int totalPlaces;

  Event({
    required this.id,
    required this.company,
    required this.headquarters,
    required this.name,
    required this.eventDate,
    required this.startTime,
    required this.endTime,
    required this.availablePlaces,
    required this.totalPlaces,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        company: CompanyEvent.fromJson(json["company"]),
        headquarters: HeadquartersEvent.fromJson(json["headquarters"]),
        name: json["name"],
        eventDate: DateTime.parse(json["eventDate"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        availablePlaces: json["availablePlaces"],
        totalPlaces: json["totalPlaces"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company": company.toJson(),
        "headquarters": headquarters.toJson(),
        "name": name,
        "eventDate":
            "${eventDate.year.toString().padLeft(4, '0')}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}",
        "startTime": startTime,
        "endTime": endTime,
        "availablePlaces": availablePlaces,
        "totalPlaces": totalPlaces,
      };
}

class CompanyEvent {
  int id;
  String name;

  CompanyEvent({
    required this.id,
    required this.name,
  });

  factory CompanyEvent.fromJson(Map<String, dynamic> json) => CompanyEvent(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class HeadquartersEvent {
  int id;
  String city;
  String address;

  HeadquartersEvent({
    required this.id,
    required this.city,
    required this.address,
  });

  factory HeadquartersEvent.fromJson(Map<String, dynamic> json) =>
      HeadquartersEvent(
        id: json["id"],
        city: json["city"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "address": address,
      };
}
