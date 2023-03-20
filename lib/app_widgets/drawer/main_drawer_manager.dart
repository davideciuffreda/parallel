import 'package:flutter/material.dart';

import 'package:parallel/routing/router_constants.dart';

class MainDrawerManager extends StatelessWidget {
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
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Nome Cognome",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(homePageManagerRoute);
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
