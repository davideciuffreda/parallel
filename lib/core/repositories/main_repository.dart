// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:dio/dio.dart';
import 'package:parallel/core/models/access/access.dart';
import 'package:parallel/core/models/booking/booking.dart';
import 'package:parallel/core/models/event/event.dart';
import 'package:parallel/core/models/event/eventBooking.dart';
import 'package:parallel/core/models/headquarter/headquarter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parallel/core/models/headquarter/headquarterCompany.dart';
import 'package:parallel/core/models/workplace/workplace.dart';
import 'package:parallel/core/models/workspace/workspace.dart';
import 'package:parallel/core/models/workplace/wpBooking.dart';
import 'package:parallel/core/models/company/company.dart';
import 'package:shared_preferences/shared_preferences.dart';

///MainRepository gestisce le richieste HTTP di Parallel e in alcuni
///casi la memoria locale
class MainRepository {
  MainRepository();

  final storage = FlutterSecureStorage();

  final String baseUrl = "http://172.16.219.94:8080/api/v1";

  ///getHeadquarters ottiene la lista di tutte le sedi registrate.
  ///INPUT: -
  ///OUTPUT: lista di headquarter
  ///TIPOLOGIA: GET
  Future<List<Headquarter>> getHeadquarters() async {
    List<Headquarter> headquarters = [];
    var hqResponse;

    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      hqResponse = await dio.get("$baseUrl/headquarters");

      if (hqResponse.statusCode == 200) {
        var parsedResponse =
            hqResponse.data.map((hq) => Headquarter.fromJson(hq)).toList();
        headquarters = List<Headquarter>.from(parsedResponse);
        return headquarters;
      }
    } catch (e) {
      print(e.toString());
      return headquarters;
    }
    return headquarters;
  }

  ///getHeadquartersByCompany ottiene la lista di tutte le sedi di una
  ///specifica company
  ///INPUT: -
  ///OUTPUT: lista di headquarter
  //////TIPOLOGIA: GET
  Future<List<HeadquarterCompany>> getHeadquartersByCompany() async {
    List<HeadquarterCompany> headquarters = [];
    var hqResponse;
    final prefs = await SharedPreferences.getInstance();
    String? token = await storage.read(key: 'userToken');
    int? cmId = await prefs.getInt('scopeId');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      hqResponse = await dio.get("$baseUrl/companies/$cmId/headquarters");

      if (hqResponse.statusCode == 200) {
        var parsedResponse = hqResponse.data
            .map((hq) => HeadquarterCompany.fromJson(hq))
            .toList();
        headquarters = List<HeadquarterCompany>.from(parsedResponse);
        return headquarters;
      }
    } catch (e) {
      print(e.toString());
      return headquarters;
    }
    return headquarters;
  }

  ///getWorkspacesByDate ottiene la lista di tutti i workspace in una
  ///determinata data
  ///INPUT: id headquarter, data di prenotazione
  ///OUTPUT: lista di workspace
  //////TIPOLOGIA: GET
  Future<List<Workspace>> getWorkspacesByDate(
      int hqId, String bookingDate) async {
    List<Workspace> workspaces = [];
    var wResponse;

    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      wResponse = await dio.get(
        "$baseUrl/headquarters/$hqId/workspaces?bookingDate=$bookingDate",
      );

      if (wResponse.statusCode == 200) {
        var parsedResponse = wResponse.data
            .map((workspace) => Workspace.fromJson(workspace))
            .toList();
        workspaces = List<Workspace>.from(parsedResponse);
        return workspaces;
      }
    } catch (e) {
      print(e.toString());
      return workspaces;
    }
    return workspaces;
  }

  ///getWorkplacesByWorkspace ottiene la lista di tutte le postazioni
  ///di un workspace
  ///INPUT: id headquarter, id workspace, data di prenotazione
  ///OUTPUT: lista di workplace
  //////TIPOLOGIA: GET
  Future<List<Workplace>> getWorkplacesByWorkspace(
    int hqId,
    int wsId,
    String bookingDate,
  ) async {
    List<Workplace> workplaces = [];
    var wResponse;

    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      wResponse = await dio.get(
        "$baseUrl/headquarters/$hqId/workspaces/$wsId/workplaces/available?on=$bookingDate",
      );

      if (wResponse.statusCode == 200) {
        var parsedResponse = wResponse.data
            .map((workplace) => Workplace.fromJson(workplace))
            .toList();
        workplaces = List<Workplace>.from(parsedResponse);
        return workplaces;
      }
    } catch (e) {
      print(e.toString());
      return workplaces;
    }
    return workplaces;
  }

  ///getBookingsByToken ottiene la lista di tutte le prenotazioni di un
  ///determinato utente a partire dal token
  ///INPUT: -
  ///OUTPUT: lista di prenotazioni
  //////TIPOLOGIA: GET
  Future<List<WpBooking>> getBookingsByToken() async {
    List<WpBooking> myBookings = [];
    var bResponse;

    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      bResponse = await dio.get("$baseUrl/workplaces/bookings");

      if (bResponse.statusCode == 200) {
        var parsedResponse = bResponse.data
            .map((booking) => WpBooking.fromJson(booking))
            .toList();
        myBookings = List<WpBooking>.from(parsedResponse);
        return myBookings;
      }
    } catch (e) {
      print(e.toString());
      return myBookings;
    }
    return myBookings;
  }

  ///setFavoriteHeadquarter imposta una sede come preferita o la rimuove dalle
  ///preferite attraverso l'attributo "favorite"
  ///INPUT: id headquarter
  ///OUTPUT: codice di risposta della richiesta HTTP
  //////TIPOLOGIA: PATCH
  Future<int> setFavoriteHeadquarter(int hqId) async {
    var response;
    String? token = await storage.read(key: 'userToken');
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.patch("$baseUrl/headquarters/favs/$hqId");

      //print("[StatusCode] " + response.statusCode.toString());

      return response.statusCode;
    } catch (e) {
      print(e.toString());
    }
    return 0;
  }

  ///checkInUser effettua il check-in di un utente. Operazione esclusivamente
  ///a cura del RECEPTIONIST
  ///INPUT: id workspace, id workplace, id prenotazione
  ///OUTPUT: codice di risposta della richiesta HTTP
  //////TIPOLOGIA: PATCH
  Future<int> checkInUser(int wsId, int wpId, int bkId) async {
    var response;
    String? token = await storage.read(key: 'userToken');
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.patch(
        "$baseUrl/workspaces/$wsId/workplaces/$wpId/bookings/$bkId",
      );

      //print("[StatusCode] " + response.statusCode.toString());

      return response.statusCode;
    } catch (e) {
      print(e.toString());
    }
    return 0;
  }

  ///setEventPresence effettua l'iscrizione di un utente ad un evento
  ///INPUT: id headquarter, id evento
  ///OUTPUT: codice di risposta della richiesta HTTP
  //////TIPOLOGIA: POST
  Future<int> setEventPresence(int hqId, int evId) async {
    var response;
    String? token = await storage.read(key: 'userToken');
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.post(
        "$baseUrl/headquarters/$hqId/events/$evId/bookings",
        data: {},
      );

      //print('HTTP ' + "$baseUrl/headquarters/$hqId/events/$evId/bookings");

      return response.statusCode;
    } catch (e) {
      print(e.toString());
    }
    return 0;
  }

  ///createNewEvent crea un nuovo evento
  ///INPUT: id headquarter, nome evento, data evento, ora di inizio,
  ///ora di fine e numero di posti
  ///OUTPUT: oggetto Event
  //////TIPOLOGIA: POST
  Future<Event?> createNewEvent(
    int hqId,
    String name,
    String eventDate,
    String startTime,
    String endTime,
    int maxPlaces,
  ) async {
    Event? newEvent;
    var response;
    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.post(
        "$baseUrl/headquarters/$hqId/events",
        data: {
          "name": name,
          "eventDate": eventDate,
          "startTime": startTime,
          "endTime": endTime,
          "maxPlaces": maxPlaces,
        },
      );

      if (response.statusCode == 201) {
        newEvent = Event.fromJson(response.data);
        return newEvent;
      }
    } catch (e) {
      print(e.toString());
      return newEvent;
    }
    return newEvent;
  }

  ///createBooking crea una nuova prenotazione
  ///INPUT: id workspace, id workplace, data di prenotazione
  ///OUTPUT: oggetto Booking
  //////TIPOLOGIA: POST
  Future<Booking> createBooking(
    int wsId,
    int wpId,
    String bookingDate,
  ) async {
    Booking booking = Booking(
      id: -1,
      workplaceId: 0,
      bookingDate: DateTime(0),
      bookedOn: DateTime(0),
      present: false,
    );
    var response;

    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.post(
        "$baseUrl/workspaces/$wsId/workplaces/$wpId/bookings",
        data: {
          "bookingDate": bookingDate,
        },
      );

      if (response.statusCode == 201) {
        booking = Booking.fromJson(response.data);
        return booking;
      }
    } catch (e) {
      print(e.toString());
      return booking;
    }
    return booking;
  }

  ///deleteBooking cancella una prenotazione
  ///INPUT: id workspace, id workplace, id prenotazione
  ///OUTPUT: stringa esito
  //////TIPOLOGIA: DELETE
  Future<String> deleteBooking(int wsId, int wpId, int bkId) async {
    var response;
    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.delete(
        "$baseUrl/workspaces/$wsId/workplaces/$wpId/bookings/$bkId",
      );

      if (response.statusCode == 204) {
        return "booking_deleted";
      }
    } catch (e) {
      print(e.toString());
      return "booking_not_deleted";
    }
    return "booking_not_deleted";
  }

  ///deleteEvent rimuove un evento. Operazione esclusivamente a cura di un
  ///COMPANY_MANAGER
  ///INPUT: id headquarter, id evento
  ///OUTPUT: codice di risposta della richiesta HTTP 
  //////TIPOLOGIA: DELETE
  Future<int> deleteEvent(int hqId, int evId) async {
    var response;
    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.delete(
        "$baseUrl/headquarters/$hqId/events/$evId",
      );

      return response.statusCode;
    } catch (e) {
      print(e.toString());
    }
    return 0;
  }

  ///deleteEventBooking cancella l'iscrizione ad un evento
  ///INPUT: id headquarter, id evento, id prenotazione
  ///OUTPUT: codice di risposta della richiesta HTTP 
  //////TIPOLOGIA: DELETE
  Future<int> deleteEventBooking(int hqId, int evId, int bkId) async {
    var response;
    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      response = await dio.delete(
        "$baseUrl/headquarters/$hqId/events/$evId/bookings/$bkId",
      );

      return response.statusCode;
    } catch (e) {
      print(e.toString());
    }
    return 0;
  }

  ///getEvents ottiene la lista di tutti gli eventi
  ///INPUT: -
  ///OUTPUT: lista di eventi
  //////TIPOLOGIA: GET
  Future<List<Event>> getEvents() async {
    List<Event> events = [];
    var eResponse;

    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      eResponse = await dio.get("$baseUrl/events");

      if (eResponse.statusCode == 200) {
        var parsedResponse =
            eResponse.data.map((ev) => Event.fromJson(ev)).toList();
        events = List<Event>.from(parsedResponse);
        return events;
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return events;
    }
    return events;
  }

  ///getMyEvents ottiene la lista di tutti gli eventi a cui un utente è iscritto
  ///INPUT: -
  ///OUTPUT: lista di eventi
  //////TIPOLOGIA: GET
  Future<List<EventBooking>> getMyEvents() async {
    List<EventBooking> events = [];
    var eResponse;

    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      eResponse = await dio.get("$baseUrl/events/bookings");

      if (eResponse.statusCode == 200) {
        var parsedResponse =
            eResponse.data.map((ev) => EventBooking.fromJson(ev)).toList();
        events = List<EventBooking>.from(parsedResponse);
        return events;
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return events;
    }
    return events;
  }

  ///getAccessLog ottiene la lista di tutti coloro che nella giornata odierna
  ///hanno fatto l'accesso ad una sede. Operazione esclusivamente a cura del
  ///RECEPTIONIST
  ///INPUT: id headquarter, token
  ///OUTPUT: lista di accessi
  //////TIPOLOGIA: GET
  Future<List<Access>> getAccessLog(int hqId, String token) async {
    List<Access> accessLog = [];

    var aResponse;
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      aResponse = await dio.get(
        "$baseUrl/headquarters/$hqId/workplaces/bookings/current-day",
      );

      if (aResponse.statusCode == 200) {
        var parsedResponse =
            aResponse.data.map((access) => Access.fromJson(access)).toList();
        accessLog = List<Access>.from(parsedResponse);
        return accessLog;
      }
    } catch (e) {
      print("Exception -> " + e.toString());
      return accessLog;
    }
    return accessLog;
  }

  ///getHeadquarterById ottiene i dati di un headquarter a partire dal suo ID
  ///INPUT: id headquarter
  ///OUTPUT: oggetto Headquarter
  //////TIPOLOGIA: GET
  Future<Headquarter> getHeadquarterById(int id) async {
    Headquarter headquarter = Headquarter(
      id: id,
      city: '',
      address: '',
      description: '',
      totalWorkplaces: 0,
      phoneNumber: '',
      company: Company(
        id: -1,
        name: '',
        city: '',
        address: '',
        phoneNumber: '',
        description: '',
        websiteUrl: '',
      ),
      favorite: false,
    );

    String idHq = id.toString();
    var hqResponse;
    String? token = await storage.read(key: 'userToken');

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      hqResponse = await dio.get("$baseUrl/headquarters/$idHq");

      if (hqResponse.statusCode == 200) {
        headquarter = Headquarter.fromJson(hqResponse.data);
        return headquarter;
      }
    } catch (e) {
      print(e.toString());
      return headquarter;
    }
    return headquarter;
  }

  ///changePassword permette il cambio password
  ///INPUT: vecchia password, nuova password, conferma nuova password, token
  ///OUTPUT: stringa esito
  //////TIPOLOGIA: PUT
  Future<String> changePassword(
    String oldPwd,
    String newPwd,
    String confirmPwd,
    String token,
  ) async {
    ;
    var response;
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.put(
        "$baseUrl/users/pwd",
        data: {
          "current": oldPwd,
          "updated": newPwd,
          "confirm": confirmPwd,
        },
      );

      if (response.statusCode == 204) {
        return "pwd_changed";
      } else {
        return "pwd_not_changed";
      }
    } catch (e) {
      print(e.toString());
    }
    return "pwd_not_changed";
  }

  ///changeUserInfo permette il cambio dati di un utente
  ///INPUT: città, indirizzo, numero di cellulare, token
  ///OUTPUT: stringa esito
  //////TIPOLOGIA: PUT
  Future<String> changeUserInfo(
    String city,
    String address,
    String phoneNumber,
    String token,
  ) async {
    ;
    var response;
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.put(
        "$baseUrl/users",
        data: {
          "phoneNumber": phoneNumber,
          "city": city,
          "address": address,
        },
      );

      if (response.statusCode == 204) {
        return "info_changed";
      } else {
        return "info_not_changed";
      }
    } catch (e) {
      print(e.toString());
    }
    return "info_not_changed";
  }
}
