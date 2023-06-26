// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

HeadquarterCompany headquarterCompanyFromJson(String str) =>
    HeadquarterCompany.fromJson(json.decode(str));

String headquarterCompanyToJson(HeadquarterCompany data) =>
    json.encode(data.toJson());

class HeadquarterCompany {
  int id;
  int companyId;
  String city;
  String address;
  String phoneNumber;
  String description;
  int totalWorkplaces;

  HeadquarterCompany({
    required this.id,
    required this.companyId,
    required this.city,
    required this.address,
    required this.phoneNumber,
    required this.description,
    required this.totalWorkplaces,
  });

  ///factory method che restituisce un'istanza di HeadquarterCompany.
  ///fromJson accetta un argomento json di tipo Map<String, dynamic>
  ///e restituisce un nuovo oggetto HeadquarterCompany utilizzando i
  ///dati del JSON.
  factory HeadquarterCompany.fromJson(Map<String, dynamic> json) =>
      HeadquarterCompany(
        id: json["id"],
        companyId: json["companyId"],
        city: json["city"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        description: json["description"],
        totalWorkplaces: json["totalWorkplaces"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyId": companyId,
        "city": city,
        "address": address,
        "phoneNumber": phoneNumber,
        "description": description,
        "totalWorkplaces": totalWorkplaces,
      };
}
