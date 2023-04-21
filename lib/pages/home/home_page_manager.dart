import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/pages/events/events_page.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';

class HomePageManager extends StatefulWidget {
  @override
  State<HomePageManager> createState() => _HomePageManager();
}

class _HomePageManager extends State<HomePageManager> {
  late List<Map<String, Object>> _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': EventsPage(),
        'title': 'Ingressi',
      },
      {
        'page': EventsPage(),
        'title': 'Prenotazioni',
      },
      {
        'page': EventsPage(),
        'title': 'Prenotazioni',
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
        child: DrawerManager(),
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
            icon: Icon(Icons.login_outlined),
            label: "Ingressi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: "Prenotazioni",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: "Random",
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
