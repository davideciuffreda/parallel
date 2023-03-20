import 'package:flutter/material.dart';
import 'package:parallel/app_widgets/main_drawer.dart';

class BookingsPage extends StatefulWidget {
  @override
  State<BookingsPage> createState() => _BookingsPage();
}

class _BookingsPage extends State<BookingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prenotazioni"),
      ),
      drawer: MainDrawer(),
    );
  }
}
