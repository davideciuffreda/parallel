// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Drawer per l'utente EMPLOYEE
class DrawerEmployee extends StatelessWidget {

  ///getUserInfo ottiene le info dell'utente
  Future<Map<String, String>> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstName = prefs.getString('firstName') ?? '';
    String lastName = prefs.getString('lastName') ?? '';

    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
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
                          backgroundImage:
                              AssetImage("assets/images/profile.png"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FutureBuilder<Map<String, String>>(
                          future: getUserInfo(),
                          builder: (BuildContext context,
                              AsyncSnapshot<Map<String, String>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Visualizza un caricamento mentre si attendono le informazioni
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // Gestisci eventuali errori
                              return Text('Errore: ${snapshot.error}');
                            } else {
                              // Se tutto è andato bene, visualizza le informazioni recuperate
                              String firstName =
                                  snapshot.data?['firstName'] ?? '';
                              String lastName =
                                  snapshot.data?['lastName'] ?? '';

                              return Text(
                                '$firstName $lastName',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return ListTile(
                      leading: Icon(Icons.home),
                      title: Text("Home"),
                      onTap: () {
                        if (state is LoginUserState) {
                          Navigator.of(context)
                              .pushReplacementNamed(homePageUserRoute);
                        }
                      },
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.manage_accounts),
                  title: Text("Profilo"),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(accountPageRoute);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.stars_rounded),
                  title: Text("Sedi preferite"),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(favHeadquartersPageRoute);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.desktop_mac_outlined),
                  title: Text("Prenotazioni"),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(bookingsPageRoute);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.calendar_month_outlined),
                  title: Text("I miei eventi"),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(myEventsPageRoute);
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
                  Navigator.of(context).pushReplacementNamed(loginPageRoute);
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
              );
            },
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
