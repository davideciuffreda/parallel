import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';

class FavoriteHeadquartersPage extends StatefulWidget {
  @override
  State<FavoriteHeadquartersPage> createState() =>
      _FavoritesHeadquartersPageState();
}

class _FavoritesHeadquartersPageState extends State<FavoriteHeadquartersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sedi preferite"),
      ),
      drawer: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginUserState) {
            return DrawerEmployee();
          } else if (state is LoginManagerState) {
            return DrawerManager();
          } else {
            return Text("Non dovresti essere arrivato a questo punto!");
          }
        },
      ),
    );
  }
}
