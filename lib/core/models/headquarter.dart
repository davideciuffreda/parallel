import 'dart:convert';

Headquarter headquarterFromJson(String str) {
  return Headquarter.fromJson(json.decode(str));
}

String headquarterToJson(Headquarter data) => json.encode(data.toJson());

class Headquarter {
  final int id;
  final String imageUrl;
  final String name;
  final String city;
  final String address;
  final String description;
  final int workstations;

  Headquarter({
    required this.address,
    required this.description,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.city,
    required this.workstations,
  });

  factory Headquarter.fromJson(Map<String, dynamic> json) {
    return Headquarter(
      id: json["id"] as int,
      imageUrl: json["imageUrl"],
      name: json["name"],
      city: json["city"],
      workstations: json["workstations"] as int,
      address: json["address"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "name": name,
        "city": city,
        "workstations": workstations,
        "address": address,
        "description": description,
      };
}
