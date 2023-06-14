// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    int id;
    String email;
    String firstName;
    String lastName;
    String role;
    int scopeId;
    String jobPosition;
    String address;
    DateTime birthDate;
    String phoneNumber;
    String city;

    User({
        required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.role,
        required this.scopeId,
        required this.jobPosition,
        required this.address,
        required this.birthDate,
        required this.phoneNumber,
        required this.city,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        role: json["role"],
        scopeId: json["scopeId"],
        jobPosition: json["jobPosition"],
        address: json["address"],
        birthDate: DateTime.parse(json["birthDate"]),
        phoneNumber: json["phoneNumber"],
        city: json["city"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
        "scopeId": scopeId,
        "jobPosition": jobPosition,
        "address": address,
        "birthDate": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "phoneNumber": phoneNumber,
        "city": city,
    };
}
