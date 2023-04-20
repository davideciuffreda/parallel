import 'package:flutter/material.dart';
import 'package:parallel/app_widgets/booking/booking_card.dart';

class AccessLogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 15,
            itemBuilder: (context, index) => BookingCard(),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
