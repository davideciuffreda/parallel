import 'dart:convert';

class User {
  String firstName;
  String lastName;
  String birthDate;
  String phoneNumber;
  String city;
  String address;

  User({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.phoneNumber,
    required this.city,
    required this.address,
  });

  User copyWith({
    String? firstName,
    String? lastName,
    String? birthDate,
    String? phoneNumber,
    String? address,
    String? city,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'city': city,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate,
    };
  }

  factory User.fromMapAPI(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      address: map['address'],
      city: map['city'],
      phoneNumber: map['phoneNumber'],
      birthDate: map['birthDate'],
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      address: map['address'],
      city: map['city'],
      phoneNumber: map['phoneNumber'],
      birthDate: map['birthDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, address: $address, city: $city, phoneNumber: $phoneNumber, birthDate: $birthDate)';
  }
}
