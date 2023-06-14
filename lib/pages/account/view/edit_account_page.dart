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
            } else if (state is LoginReceptionistState) {
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
              horizontal: 28,
              vertical: 12,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Numero di telefono',
                      hintText: 'Inserisci il numero di telefono',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: cityController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Città',
                      hintText: 'Inserisci la città',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      labelText: 'Indirizzo',
                      hintText: 'Inserisci il tuo indirizzo',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: birthDateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Data di nascita',
                      hintText: 'Inserisci la tua data di nascita',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          cityController.clear();
                          addressController.clear();
                          phoneNumberController.clear();
                          birthDateController.clear();
                          return TextButton(
                            onPressed: () {
                              if (state is LoginReceptionistState) {
                                Navigator.of(context)
                                    .pushReplacementNamed(accountPageRoute);
                              } else if (state is LoginUserState) {
                                Navigator.of(context)
                                    .pushReplacementNamed(accountPageRoute);
                              } else if (state is LoginManagerState) {
                                Navigator.of(context)
                                    .pushReplacementNamed(accountPageRoute);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Errore'),
                                      content: Text(
                                          'Si è verificato un errore durante l\'operazione.'),
                                      actions: [
                                        TextButton(
                                          child: Text('Chiudi'),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Chiude il pop-up
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text(
                              "Indietro",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return TextButton(
                            onPressed: () {
                              if (state is LoginReceptionistState) {
                                Navigator.of(context)
                                    .pushReplacementNamed(accountPageRoute);
                              } else if (state is LoginUserState) {
                                Navigator.of(context)
                                    .pushReplacementNamed(accountPageRoute);
                              } else if (state is LoginManagerState) {
                                Navigator.of(context)
                                    .pushReplacementNamed(accountPageRoute);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Errore'),
                                      content: Text(
                                          'Si è verificato un errore durante l\'operazione.'),
                                      actions: [
                                        TextButton(
                                          child: Text('Chiudi'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text(
                              "Salva",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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
