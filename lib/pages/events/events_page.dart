import 'package:flutter/material.dart';
import 'package:parallel/app_widgets/event/event_card.dart';
import 'package:intl/intl.dart';

class EventsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (context, index) => EventCard(
          image:
              'https://images.unsplash.com/photo-1591243315780-978fd00ff9db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y29ja3RhaWxzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
          name: "Oltre l'aperitivo",
          headquarter_city: "Roma",
          headquarter_name: "ELIS",
          tickets: 20,
          date: DateFormat.yMd().format(DateTime.now()),
        ),
      ),
    );
  }
}
