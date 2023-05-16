import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/pages/access_log/view/access_log_page.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';

import 'package:parallel/routing/router_constants.dart';

class DrawerReceptionist extends StatelessWidget {
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
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return ListTile(
                      leading: Icon(Icons.home),
                      title: Text("Home"),
                      onTap: () {
                        if (state is LoginUserState) {
                          Navigator.of(context)
                              .pushReplacementNamed(homePageUserRoute);
                        } else if (state is LoginAdminState) {
                          Navigator.of(context)
                              .pushReplacementNamed(homePageReceptionistRoute);
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
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
