// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

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

  ///factory method che restituisce un'istanza di Booking.
  ///fromJson accetta un argomento json di tipo Map<String, dynamic>
  ///e restituisce un nuovo oggetto Booking utilizzando i dati del JSON.
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
