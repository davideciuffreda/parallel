// To parse this JSON data, do
//
//     final workplace = workplaceFromJson(jsonString);

import 'dart:convert';

Workplace workplaceFromJson(String str) => Workplace.fromJson(json.decode(str));

String workplaceToJson(Workplace data) => json.encode(data.toJson());

class Workplace {
  int id;
  String name;
  String type;

  Workplace({
    required this.id,
    required this.name,
    required this.type,
  });

  factory Workplace.fromJson(Map<String, dynamic> json) => Workplace(
        id: json["id"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
      };
}
