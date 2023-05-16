import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parallel/pages/events/view/events_page.dart';
import 'package:parallel/pages/headquarters/view/headquarters_page.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';

class HomePageUser extends StatefulWidget {
  @override
  State<HomePageUser> createState() => _HomePageUser();
}

class _HomePageUser extends State<HomePageUser> {
  late List<Map<String, Object>> _pages;
  int _selectedIndex = 1;

  @override
  void initState() {
    _pages = [
      {
        'page': EventsPage(),
        'title': 'Eventi',
      },
      {
        'page': HeadquartersPage(),
        'title': 'Sedi',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BlocProvider(
        create: (context) => LoginBloc(),
        child: DrawerEmployee(),
      ),
      appBar: AppBar(
        title: Text(
          _pages[_selectedIndex]['title'].toString(),
        ),
      ),
      body: _pages[_selectedIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: "Eventi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place_outlined),
            label: "Sedi",
          ),
        ],
        onTap: _selectPage,
        backgroundColor: Colors.blue,
        unselectedItemColor: Colors.white60,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        iconSize: 30,
        selectedFontSize: 15,
        unselectedFontSize: 12,
      ),
    );
  }
}
