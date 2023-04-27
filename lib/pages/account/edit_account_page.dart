import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/app_widgets/drawer/drawer_receptionist.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/routing/router_constants.dart';

class EditAccountPage extends StatefulWidget {
  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Modifica account"),
        ),
        drawer: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginUserState) {
              return DrawerEmployee();
            } else if (state is LoginAdminState) {
              return DrawerReceptionist();
            } else if (state is LoginManagerState) {
              return DrawerManager();
            } else {
              return Text("Non dovresti essere arrivato a questo punto!");
            }
          },
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 12,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Numero di telefono',
                      hintText: 'Inserisci il numero di telefono',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: cityController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Città',
                      hintText: 'Inserisci la città',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Indirizzo',
                      hintText: 'Inserisci il tuo indirizzo',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: birthDateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data di nascita',
                      hintText: 'Inserisci la tua data di nascita',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Inserisci nuova password',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Conferma password',
                      hintText: 'Inserisci ancora la nuova password',
                    ),
                  ),
                  SizedBox(height: 10),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (state is LoginAdminState) {
                            Navigator.of(context)
                                .pushReplacementNamed(homePageReceptionistRoute);
                          } else if (state is LoginUserState) {
                            Navigator.of(context)
                                .pushReplacementNamed(homePageUserRoute);
                          } else if (state is LoginManagerState) {
                            Navigator.of(context)
                                .pushReplacementNamed(homePageManagerRoute);
                          }
                        },
                        child: Text(
                          "Salva modifiche",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
