// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

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

  ///factory method che restituisce un'istanza di Workplace.
  ///fromJson accetta un argomento json di tipo Map<String, dynamic>
  ///e restituisce un nuovo oggetto Workplace utilizzando i dati del JSON.
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
