// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  int id;
  String name;
  String city;
  String address;
  String phoneNumber;
  String description;
  String websiteUrl;

  Company({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.phoneNumber,
    required this.description,
    required this.websiteUrl,
  });

  ///factory method che restituisce un'istanza di Company.
    ///fromJson accetta un argomento json di tipo Map<String, dynamic>
    ///e restituisce un nuovo oggetto Company utilizzando i dati del JSON.
  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        description: json["description"],
        websiteUrl: json["websiteUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "address": address,
        "phoneNumber": phoneNumber,
        "description": description,
        "websiteUrl": websiteUrl,
      };
}
