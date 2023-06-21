import 'package:dio/dio.dart';
import 'package:parallel/core/models/access.dart';
import 'package:parallel/core/models/booking.dart';
import 'package:parallel/core/models/event.dart';
import 'package:parallel/core/models/eventBooking.dart';
import 'package:parallel/core/models/headquarter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parallel/core/models/headquarterCompany.dart';
import 'package:parallel/core/models/workplace.dart';
import 'package:parallel/core/models/workspace.dart';
import 'package:parallel/core/models/wpBooking.dart';
import 'package:parallel/core/models/company.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainRepository {
  MainRepository();

  final storage = FlutterSecureStorage();

  final String baseUrl = "http://172.16.216.51:8080/api/v1";

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

  Future<Event?> createNewEvent(
    int id,
    String name,
    String eventDate,
    String startTime,
    String endTime,
    int maxPlaces,
  ) async {
    Event? newEvent;
    var response;
    String? token = await storage.read(key: 'userToken');

    /*print("[Token] " + token.toString());
    print("[ID] " + id.toString());
    print("[Name] " + name);
    print("[EventDate] " + eventDate);
    print("[startTime] " + startTime);
    print("[endTime] " + endTime);
    print("[maxPlaces] " + maxPlaces.toString());*/

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.post(
        "$baseUrl/headquarters/$id/events",
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

    /* print("[bkDt] " + bookingDate);
    print("[wsIdRepo] " + wsId.toString());
    print("[wpIdRepo] " + wpId.toString()); */

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

  Future<String> deleteBooking(int wsId, int wpId, int bkId) async {
    var response;
    String? token = await storage.read(key: 'userToken');

    /*print("[bkIdRepo] " + bkId.toString());
    print("[wsIdRepo] " + wsId.toString());
    print("[wpIdRepo] " + wpId.toString());*/

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

  Future<Headquarter> getHeadquarterById(int id) async {
    String? token = await storage.read(key: 'userToken');

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
