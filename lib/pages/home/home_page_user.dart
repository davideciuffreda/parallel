import 'package:flutter/material.dart';

import 'package:parallel/pages/events/events_page.dart';
import 'package:parallel/pages/forum/forum_page.dart';
import 'package:parallel/pages/headquarters/headquarters_page.dart';
import 'package:parallel/pages/notifications/notifications_page.dart';
import 'package:parallel/app_widgets/drawer/main_drawer.dart';
import 'package:parallel/routing/router_constants.dart';

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
      {
        'page': ForumPage(),
        'title': 'Forum',
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
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
          _pages[_selectedIndex]['title'].toString(),
        ),
        actions: <Widget>[
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(NotificationsPage.routeName);
                    },
                    child: Icon(
                      Icons.notifications_none,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_outlined),
            label: "Forum",
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
