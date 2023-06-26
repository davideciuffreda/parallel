// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/app_widgets/drawer/drawer_receptionist.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  ///getUserInfo recupera le info dell'utente loggato dalla memoria locale
  Future<Map<String, String>> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstName = prefs.getString('firstName') ?? '';
    String lastName = prefs.getString('lastName') ?? '';
    String email = prefs.getString('email') ?? '';
    String city = prefs.getString('city') ?? '';
    String address = prefs.getString('address') ?? '';
    String phoneNumber = prefs.getString('phoneNumber') ?? '';
    String birthDate = prefs.getString('birthDate') ?? '';
    String jobPosition = prefs.getString('jobPosition') ?? '';

    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'city': city,
      'address': address,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate,
      'jobPosition': jobPosition,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profilo"),
        actions: [
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
                  Navigator.of(context).pushReplacementNamed(loginPageRoute);
                },
                icon: Icon(Icons.logout_outlined),
              );
            },
          ),
        ],
      ),
      drawer: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginUserState) {
            return DrawerEmployee();
          } else if (state is LoginReceptionistState) {
            return DrawerReceptionist();
          } else if (state is LoginManagerState) {
            return DrawerManager();
          } else {
            return Text("Non dovresti essere arrivato a questo punto!");
          }
        },
      ),

      ///Creazione di un layout scorrevole che può contenere widget che
      ///potrebbero superare lo spazio disponibile su schermo
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  width: 130,
                  child: ClipRRect(
                    ///Il widget figlio sarà ritagliato in un
                    ///rettangolo arrotondato
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                ///Widget utilizzato per gestire il rendering dell'interfaccia
                ///utente in base allo stato di un oggetto Future
                FutureBuilder<Map<String, String>>(
                  future: getUserInfo(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<Map<String, String>> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      ///Gestione di eventuali errori
                      return Text('Errore: ${snapshot.error}');
                    } else {
                      ///Se tutto è andato bene, visualizza le info recuperate
                      String firstName = snapshot.data?['firstName'] ?? '';
                      String lastName = snapshot.data?['lastName'] ?? '';
                      String email = snapshot.data?['email'] ?? '';
                      String city = snapshot.data?['city'] ?? '';
                      String phoneNumber = snapshot.data?['phoneNumber'] ?? '';
                      String address = snapshot.data?['address'] ?? '';
                      String jobPosition = snapshot.data?['jobPosition'] ?? '';
                      String birthDate =
                          snapshot.data?['birthDate']!.substring(0, 10) ?? '';

                      return Column(
                        children: [
                          Text(
                            '$firstName $lastName',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '$email',
                            style: TextStyle(
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '$jobPosition',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Cell: $phoneNumber',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '$address, ' + '$city',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Data di nascita: $birthDate',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 55,
                      width: 110,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue,
                          ),
                        ),
                        child: Text(
                          "Modifica dati",
                          style: TextStyle(fontSize: 17),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(editAccountPageRoute);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      width: 110,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue,
                          ),
                        ),
                        child: Text(
                          "Modifica password",
                          style: TextStyle(fontSize: 17),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(editPasswordPageRoute);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
