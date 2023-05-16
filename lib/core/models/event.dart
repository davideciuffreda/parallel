import 'dart:convert';

import 'package:parallel/core/models/headquarter.dart';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
    final int id;
    final String imageUrl;
    final String name;
    final int tickets;
    final Headquarter headquarter;
    final String date;

    Event({
        required this.id,
        required this.imageUrl,
        required this.name,
        required this.tickets,
        required this.headquarter,
        required this.date,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"] as int,
        imageUrl: json["imageUrl"],
        name: json["name"],
        tickets: json["tickets"] as int,
        headquarter: Headquarter.fromJson(json["headquarter"]),
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "name": name,
        "tickets": tickets,
        "headquarter": headquarter.toJson(),
        "date": date,
    };
}