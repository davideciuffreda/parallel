// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

Access accessFromJson(String str) => Access.fromJson(json.decode(str));

String accessToJson(Access data) => json.encode(data.toJson());

class Access {
    int id;
    Worker worker;
    acWorkspace workspace;
    acWorkplace workplace;
    DateTime bookingDate;
    DateTime bookedOn;
    bool present;

    Access({
        required this.id,
        required this.worker,
        required this.workspace,
        required this.workplace,
        required this.bookingDate,
        required this.bookedOn,
        required this.present,
    });

    ///factory method che restituisce un'istanza di Access.
    ///fromJson accetta un argomento json di tipo Map<String, dynamic>
    ///e restituisce un nuovo oggetto Access utilizzando i dati del JSON.
    factory Access.fromJson(Map<String, dynamic> json) => Access(
        id: json["id"],
        worker: Worker.fromJson(json["worker"]),
        workspace: acWorkspace.fromJson(json["workspace"]),
        workplace: acWorkplace.fromJson(json["workplace"]),
        bookingDate: DateTime.parse(json["bookingDate"]),
        bookedOn: DateTime.parse(json["bookedOn"]),
        present: json["present"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "worker": worker.toJson(),
        "workspace": workspace.toJson(),
        "workplace": workplace.toJson(),
        "bookingDate": "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "bookedOn": "${bookedOn.year.toString().padLeft(4, '0')}-${bookedOn.month.toString().padLeft(2, '0')}-${bookedOn.day.toString().padLeft(2, '0')}",
        "present": present,
    };
}

class Worker {
    int id;
    String firstName;
    String lastName;
    String email;
    String companyName;

    Worker({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.companyName,
    });

    ///factory method che restituisce un'istanza di Worker.
    ///fromJson accetta un argomento json di tipo Map<String, dynamic>
    ///e restituisce un nuovo oggetto Worker utilizzando i dati del JSON.
    factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        companyName: json["companyName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "companyName": companyName,
    };
}

class acWorkplace {
    int id;
    String name;

    acWorkplace({
        required this.id,
        required this.name,
    });

    ///factory method che restituisce un'istanza di acWorkplace.
    ///fromJson accetta un argomento json di tipo Map<String, dynamic>
    ///e restituisce un nuovo oggetto acWorkplace utilizzando i dati del JSON.
    factory acWorkplace.fromJson(Map<String, dynamic> json) => acWorkplace(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class acWorkspace {
    int id;
    String name;
    String floor;

    acWorkspace({
        required this.id,
        required this.name,
        required this.floor,
    });

    ///factory method che restituisce un'istanza di acWorkspace.
    ///fromJson accetta un argomento json di tipo Map<String, dynamic>
    ///e restituisce un nuovo oggetto acWorkspace utilizzando i dati del JSON.
    factory acWorkspace.fromJson(Map<String, dynamic> json) => acWorkspace(
        id: json["id"],
        name: json["name"],
        floor: json["floor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "floor": floor,
    };
}
