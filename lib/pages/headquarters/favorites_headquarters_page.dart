import 'package:flutter/material.dart';
import 'package:parallel/app_widgets/drawer/main_drawer.dart';

class FavoritesHeadquartersPage extends StatefulWidget {
  @override
  State<FavoritesHeadquartersPage> createState() =>
      _FavoritesHeadquartersPageState();
}

class _FavoritesHeadquartersPageState extends State<FavoritesHeadquartersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sedi preferite"),
      ),
      drawer: MainDrawer(),
    );
  }
}
