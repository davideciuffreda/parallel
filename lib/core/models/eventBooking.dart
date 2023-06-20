// To parse this JSON data, do
//
//     final eventBooking = eventBookingFromJson(jsonString);

import 'dart:convert';

EventBooking eventBookingFromJson(String str) =>
    EventBooking.fromJson(json.decode(str));

String eventBookingToJson(EventBooking data) => json.encode(data.toJson());

class EventBooking {
  int id;
  CompanyBook company;
  HeadquartersBook headquarters;
  EventBooked event;
  DateTime bookedOn;

  EventBooking({
    required this.id,
    required this.company,
    required this.headquarters,
    required this.event,
    required this.bookedOn,
  });

  factory EventBooking.fromJson(Map<String, dynamic> json) => EventBooking(
        id: json["id"],
        company: CompanyBook.fromJson(json["company"]),
        headquarters: HeadquartersBook.fromJson(json["headquarters"]),
        event: EventBooked.fromJson(json["event"]),
        bookedOn: DateTime.parse(json["bookedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company": company.toJson(),
        "headquarters": headquarters.toJson(),
        "event": event.toJson(),
        "bookedOn":
            "${bookedOn.year.toString().padLeft(4, '0')}-${bookedOn.month.toString().padLeft(2, '0')}-${bookedOn.day.toString().padLeft(2, '0')}",
      };
}

class CompanyBook {
  int id;
  String name;

  CompanyBook({
    required this.id,
    required this.name,
  });

  factory CompanyBook.fromJson(Map<String, dynamic> json) => CompanyBook(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class EventBooked {
  int id;
  String name;
  DateTime onDate;
  String startTime;
  String endTime;
  int availablePlaces;
  int totalPlaces;

  EventBooked({
    required this.id,
    required this.name,
    required this.onDate,
    required this.startTime,
    required this.endTime,
    required this.availablePlaces,
    required this.totalPlaces,
  });

  factory EventBooked.fromJson(Map<String, dynamic> json) => EventBooked(
        id: json["id"],
        name: json["name"],
        onDate: DateTime.parse(json["onDate"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        availablePlaces: json["availablePlaces"],
        totalPlaces: json["totalPlaces"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "onDate":
            "${onDate.year.toString().padLeft(4, '0')}-${onDate.month.toString().padLeft(2, '0')}-${onDate.day.toString().padLeft(2, '0')}",
        "startTime": startTime,
        "endTime": endTime,
        "availablePlaces": availablePlaces,
        "totalPlaces": totalPlaces,
      };
}

class HeadquartersBook {
  int id;
  String city;
  String address;

  HeadquartersBook({
    required this.id,
    required this.city,
    required this.address,
  });

  factory HeadquartersBook.fromJson(Map<String, dynamic> json) =>
      HeadquartersBook(
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
