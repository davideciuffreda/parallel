import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parallel/core/models/event.dart';

class MainRepository {
  Future<List<Event>> fetchEvents() async {
    List<Event> events = [];
    var eventsResponse;

    try {
      eventsResponse = await http.get(Uri.parse(
          'https://parallel-test-797b5-default-rtdb.europe-west1.firebasedatabase.app/parallel/events'));

      if (eventsResponse.statusCode == 200) {
        var parsedEvents =
            json.decode(utf8.decode(eventsResponse.body.codeUnits)) as List;
        events =
            parsedEvents.map((rawEvents) => Event.fromJson(rawEvents)).toList();
      }

      return events;
    } catch (err) {
      print("Errore in GET events");
    }
    return events;
  }
}
