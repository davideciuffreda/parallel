// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

import 'package:parallel/core/models/company/company.dart';

Headquarter headquarterFromJson(String str) =>
    Headquarter.fromJson(json.decode(str));

String headquarterToJson(Headquarter data) => json.encode(data.toJson());

class Headquarter {
  int id;
  Company company;
  String city;
  String address;
  String phoneNumber;
  String description;
  int totalWorkplaces;
  bool favorite;

  Headquarter({
    required this.id,
    required this.company,
    required this.city,
    required this.address,
    required this.phoneNumber,
    required this.description,
    required this.totalWorkplaces,
    required this.favorite,
  });

  ///factory method che restituisce un'istanza di Headquarter.
  ///fromJson accetta un argomento json di tipo Map<String, dynamic>
  ///e restituisce un nuovo oggetto Headquarter utilizzando i dati del JSON.
  factory Headquarter.fromJson(Map<String, dynamic> json) => Headquarter(
        id: json["id"],
        company: Company.fromJson(json["company"]),
        city: json["city"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        description: json["description"],
        totalWorkplaces: json["totalWorkplaces"],
        favorite: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company": company.toJson(),
        "city": city,
        "address": address,
        "phoneNumber": phoneNumber,
        "description": description,
        "totalWorkplaces": totalWorkplaces,
        "favorite": favorite,
      };
}
