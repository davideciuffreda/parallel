// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    int id;
    String email;
    String firstName;
    String lastName;
    DateTime birthDate;
    String phoneNumber;
    String city;
    String address;
    String role;
    ///ID utile a seconda del role dell'utente che esegue il login
    int scopeId;
    String jobPosition;

    User({
        required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.birthDate,
        required this.phoneNumber,
        required this.city,
        required this.address,
        required this.role,
        required this.scopeId,
        required this.jobPosition,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        birthDate: DateTime.parse(json["birthDate"]),
        phoneNumber: json["phoneNumber"],
        city: json["city"],
        address: json["address"],
        role: json["role"],
        scopeId: json["scopeId"],
        jobPosition: json["jobPosition"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "birthDate": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "phoneNumber": phoneNumber,
        "city": city,
        "address": address,
        "role": role,
        "scopeId": scopeId,
        "jobPosition": jobPosition,
    };
}
