// To parse this JSON data, do
//
//     final booking = bookingFromJson(jsonString);

import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  int id;
  int workplaceId;
  DateTime bookingDate;
  DateTime bookedOn;
  bool present;

  Booking({
    required this.id,
    required this.workplaceId,
    required this.bookingDate,
    required this.bookedOn,
    required this.present,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        workplaceId: json["workplaceId"],
        bookingDate: DateTime.parse(json["bookingDate"]),
        bookedOn: DateTime.parse(json["bookedOn"]),
        present: json["present"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workplaceId": workplaceId,
        "bookingDate":
            "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "bookedOn":
            "${bookedOn.year.toString().padLeft(4, '0')}-${bookedOn.month.toString().padLeft(2, '0')}-${bookedOn.day.toString().padLeft(2, '0')}",
        "present": present,
      };
}
