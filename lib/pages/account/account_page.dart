import 'package:flutter/material.dart';

import 'package:parallel/app_widgets/main_drawer.dart';
import 'package:parallel/routing/router_constants.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profilo"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/profile.png"),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Nome Cognome",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "nomecognome@mail.com",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    child: Text("Modifica"),
                    onPressed: () {
                      
                    },
                  ),
                ),
                SizedBox(
                  height: 380,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Log out",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
