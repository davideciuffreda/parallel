// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

Workspace workspaceFromJson(String str) => Workspace.fromJson(json.decode(str));

String workspaceToJson(Workspace data) => json.encode(data.toJson());

class Workspace {
  int id;
  String name;
  String description;
  String type;
  String floor;
  int availableWorkplaces;
  int totalWorkplaces;

  Workspace({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.floor,
    required this.availableWorkplaces,
    required this.totalWorkplaces,
  });

  ///factory method che restituisce un'istanza di Workspace.
  ///fromJson accetta un argomento json di tipo Map<String, dynamic>
  ///e restituisce un nuovo oggetto Workspace utilizzando i dati del JSON.
  factory Workspace.fromJson(Map<String, dynamic> json) => Workspace(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        floor: json["floor"],
        availableWorkplaces: json["availableWorkplaces"],
        totalWorkplaces: json["totalWorkplaces"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
        "floor": floor,
        "availableWorkplaces": availableWorkplaces,
        "totalWorkplaces": totalWorkplaces,
      };
}
