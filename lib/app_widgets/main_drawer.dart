import 'package:flutter/material.dart';

import 'package:parallel/pages/account/account_page.dart';
import 'package:parallel/pages/bookings/bookings_page.dart';
import 'package:parallel/pages/headquarters/favorites_headquarters_page.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // UserAccountsDrawerHeader(
          SizedBox(
            height: 100,
            width: double.infinity,
            child: DrawerHeader(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    child: Text(
                      "Nome Cognome",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AccountPage.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text("Profilo"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AccountPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.stars_rounded),
            title: Text("Sedi preferite"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FavoritesHeadquartersPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_outlined),
            title: Text("Prenotazioni"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(BookingsPage.routeName);
            },
          ),
          SizedBox(
            height: 400,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Log out",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
