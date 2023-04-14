import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  String date;
  String headquarterCity;
  String headquarterName;
  String imageLink;
  String name;
  int tickets;

  Event({
    required this.date,
    required this.headquarterCity,
    required this.headquarterName,
    required this.imageLink,
    required this.name,
    required this.tickets,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return new Event(
      date: json["date"] as String,
      headquarterCity: json["headquarter_city"] as String,
      headquarterName: json["headquarter_name"] as String,
      imageLink: json["image_link"] as String,
      name: json["name"] as String,
      tickets: json["tickets"] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "headquarter_city": headquarterCity,
        "headquarter_name": headquarterName,
        "image_link": imageLink,
        "name": name,
        "tickets": tickets,
      };
}
