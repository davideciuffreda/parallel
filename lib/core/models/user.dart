import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    final int id;
    final String firstName;
    final String lastName;
    final String email;
    final String address;
    final String city;
    final String phoneNumber;
    final String birthDate;
    final String password;
    final String token;
    final String profileImg;

    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.address,
        required this.city,
        required this.phoneNumber,
        required this.birthDate,
        required this.password,
        required this.token,
        required this.profileImg,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] as int,
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        address: json["address"],
        city: json["city"],
        phoneNumber: json["phoneNumber"],
        birthDate: json["birthDate"],
        password: json["password"],
        token: json["token"],
        profileImg: json["profileImg"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "address": address,
        "city": city,
        "phoneNumber": phoneNumber,
        "birthDate": birthDate,
        "password": password,
        "token": token,
        "profileImg": profileImg,
    };
}
