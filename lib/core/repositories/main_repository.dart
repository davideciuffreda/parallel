import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parallel/core/models/event.dart';

class MainRepository {
  Future<Event> fetchEvents() async {
    /* final response = await http.get(Uri.parse('link degli eventi'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((event) => Event(
                date: DateTime.now(),
                headquarter_city: 'Roma',
                headquarter_name: 'ELIS',
                name: 'Oltre l\'aperitivo',
                tickets: 20,
                image:
                    'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
              ))
          .toList();
    } else {
      throw Exception('Failed to fetch events.');
    } */

    return Event(
      date: DateTime.now(),
      headquarter_city: 'Roma',
      headquarter_name: 'ELIS',
      name: 'Oltre l\'aperitivo',
      tickets: 20,
      image:
          'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    );
  }
}
