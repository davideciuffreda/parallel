// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  int id;
  String name;
  String city;
  String address;
  String phoneNumber;
  String feDescription;
  String websiteUrl;

  Company({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.phoneNumber,
    required this.feDescription,
    required this.websiteUrl,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        feDescription: json["feDescription"],
        websiteUrl: json["websiteUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "address": address,
        "phoneNumber": phoneNumber,
        "feDescription": feDescription,
        "websiteUrl": websiteUrl,
      };
}
