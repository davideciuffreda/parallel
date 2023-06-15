class Company {
  int id;
  String name;
  String city;
  String address;
  String phoneNumber;
  String description;
  String websiteUrl;

  Company({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.phoneNumber,
    required this.description,
    required this.websiteUrl,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        description: json["description"],
        websiteUrl: json["websiteUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "address": address,
        "phoneNumber": phoneNumber,
        "description": description,
        "websiteUrl": websiteUrl,
      };
}
