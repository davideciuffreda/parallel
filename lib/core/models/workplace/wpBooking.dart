// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

WpBooking wpBookingFromJson(String str) => WpBooking.fromJson(json.decode(str));

String wpBookingToJson(WpBooking data) => json.encode(data.toJson());

class WpBooking {
  int id;
  wpCompany company;
  wpHeadquarters headquarters;
  wpWorkspace workspace;
  wpCompany workplace;
  DateTime bookingDate;
  DateTime bookedOn;

  WpBooking({
    required this.id,
    required this.company,
    required this.headquarters,
    required this.workspace,
    required this.workplace,
    required this.bookingDate,
    required this.bookedOn,
  });

  ///factory method che restituisce un'istanza di WpBooking.
  ///fromJson accetta un argomento json di tipo Map<String, dynamic>
  ///e restituisce un nuovo oggetto WpBooking utilizzando i dati del JSON.
  factory WpBooking.fromJson(Map<String, dynamic> json) => WpBooking(
        id: json["id"],
        company: wpCompany.fromJson(json["company"]),
        headquarters: wpHeadquarters.fromJson(json["headquarters"]),
        workspace: wpWorkspace.fromJson(json["workspace"]),
        workplace: wpCompany.fromJson(json["workplace"]),
        bookingDate: DateTime.parse(json["bookingDate"]),
        bookedOn: DateTime.parse(json["bookedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company": company.toJson(),
        "headquarters": headquarters.toJson(),
        "workspace": workspace.toJson(),
        "workplace": workplace.toJson(),
        "bookingDate":
            "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "bookedOn":
            "${bookedOn.year.toString().padLeft(4, '0')}-${bookedOn.month.toString().padLeft(2, '0')}-${bookedOn.day.toString().padLeft(2, '0')}",
      };
}

class wpCompany {
  int id;
  String name;

  wpCompany({
    required this.id,
    required this.name,
  });

  ///factory method che restituisce un'istanza di wpCompany.
  ///fromJson accetta un argomento json di tipo Map<String, dynamic>
  ///e restituisce un nuovo oggetto wpCompany utilizzando i dati del JSON.
  factory wpCompany.fromJson(Map<String, dynamic> json) => wpCompany(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class wpHeadquarters {
  int id;
  String city;
  String address;

  wpHeadquarters({
    required this.id,
    required this.city,
    required this.address,
  });

  ///factory method che restituisce un'istanza di wpHeadquarters.
  ///fromJson accetta un argomento json di tipo Map<String, dynamic>
  ///e restituisce un nuovo oggetto wpHeadquarters utilizzando i dati del JSON.
  factory wpHeadquarters.fromJson(Map<String, dynamic> json) => wpHeadquarters(
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

class wpWorkspace {
  int id;
  String name;
  String floor;

  wpWorkspace({
    required this.id,
    required this.name,
    required this.floor,
  });

  ///factory method che restituisce un'istanza di wpWorkspace.
  ///fromJson accetta un argomento json di tipo Map<String, dynamic>
  ///e restituisce un nuovo oggetto wpWorkspace utilizzando i dati del JSON.
  factory wpWorkspace.fromJson(Map<String, dynamic> json) => wpWorkspace(
        id: json["id"],
        name: json["name"],
        floor: json["floor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "floor": floor,
      };
}
