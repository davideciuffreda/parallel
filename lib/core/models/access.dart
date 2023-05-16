import 'dart:convert';

import 'package:parallel/core/models/user.dart';

Access accessFromJson(String str) => Access.fromJson(json.decode(str));

String accessToJson(Access data) => json.encode(data.toJson());

class Access {
    final int id;
    final String accessHour;
    final String leavingHour;
    final User user;

    Access({
        required this.id,
        required this.accessHour,
        required this.leavingHour,
        required this.user,
    });

    factory Access.fromJson(Map<String, dynamic> json) => Access(
        id: json["id"] as int,
        accessHour: json["accessHour"],
        leavingHour: json["leavingHour"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "accessHour": accessHour,
        "leavingHour": leavingHour,
        "user": user.toJson(),
    };
}