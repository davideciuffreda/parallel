// To parse this JSON data, do
//
//     final headquarter = headquarterFromJson(jsonString);

import 'dart:convert';

import 'package:parallel/core/models/company.dart';

Headquarter headquarterFromJson(String str) => Headquarter.fromJson(json.decode(str));

String headquarterToJson(Headquarter data) => json.encode(data.toJson());

class Headquarter {
    int id;
    Company company;
    String city;
    String address;
    String phoneNumber;
    String description;
    int totalWorkplaces;

    Headquarter({
        required this.id,
        required this.company,
        required this.city,
        required this.address,
        required this.phoneNumber,
        required this.description,
        required this.totalWorkplaces,
    });

    factory Headquarter.fromJson(Map<String, dynamic> json) => Headquarter(
        id: json["id"],
        company: Company.fromJson(json["company"]),
        city: json["city"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        description: json["description"],
        totalWorkplaces: json["totalWorkplaces"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company": company.toJson(),
        "city": city,
        "address": address,
        "phoneNumber": phoneNumber,
        "description": description,
        "totalWorkplaces": totalWorkplaces,
    };
}