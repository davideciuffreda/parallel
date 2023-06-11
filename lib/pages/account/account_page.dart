import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/app_widgets/drawer/drawer_receptionist.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatelessWidget {
  Future<Map<String, String>> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstName = prefs.getString('firstName') ?? '';
    String lastName = prefs.getString('lastName') ?? '';
    String email = prefs.getString('email') ?? '';

    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profilo"),
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
                SizedBox(height: 10),
                FutureBuilder<Map<String, String>>(
                  future: getUserInfo(),
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Visualizza uno spinner o un indicatore di caricamento mentre si attendono le informazioni
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Gestisci eventuali errori
                      return Text('Errore: ${snapshot.error}');
                    } else {
                      // Se tutto è andato bene, visualizza le informazioni recuperate
                      String firstName = snapshot.data?['firstName'] ?? '';
                      String lastName = snapshot.data?['lastName'] ?? '';
                      String email = snapshot.data?['email'] ?? '';

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
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    child: Text("Modifica"),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(editAccountPageRoute);
                    },
                  ),
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
                        Navigator.of(context)
                            .pushReplacementNamed(loginPageRoute);
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
