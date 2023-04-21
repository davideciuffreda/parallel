import 'package:flutter/material.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';

class NewEventPage extends StatefulWidget {
  @override
  State<NewEventPage> createState() => _NewEventPage();
}

class _NewEventPage extends State<NewEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crea evento"),
      ),
      drawer: DrawerManager(),
    );
  }
}
