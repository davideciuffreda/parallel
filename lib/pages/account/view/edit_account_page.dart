// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parallel/app_widgets/drawer/drawer_employee.dart';
import 'package:parallel/app_widgets/drawer/drawer_manager.dart';
import 'package:parallel/app_widgets/drawer/drawer_receptionist.dart';
import 'package:parallel/pages/account/bloc/manage_account_bloc.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/routing/router_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAccountPage extends StatefulWidget {
  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  ///Definizione dei controller per i campi del form
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  ///Dichiarazione delle librerie di gestione delle variabili locali
  final storage = FlutterSecureStorage();
  late SharedPreferences sharedPreferences;
  String? userRole;
  String? userToken;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    getToken();
  }

  ///Inizializzazione delle SharedPreferences
  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getUserRole();
  }

  ///Ottenimento del role dell'utente
  void getUserRole() {
    String? storedUserRole = sharedPreferences.getString('userRole');
    setState(() {
      userRole = storedUserRole;
    });
  }

  ///Ottenimento del token dell'utente
  void getToken() async {
    String? storedToken = await storage.read(key: 'userToken');
    setState(() {
      userToken = storedToken;
    });
  }

  ///Pulizia dei controller dei campi del form
  void clearController() {
    cityController.clear();
    addressController.clear();
    phoneNumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ///Widget utilizzato per rilevare e gestire gli input dell'utente,
    ///come tocchi, pressioni prolungate, gesture etc.
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
                    onChanged: (value) {
                      BlocProvider.of<ManageAccountBloc>(context).add(
                        ChangingUserInfoEvent(
                          cityController.text,
                          phoneNumberController.text,
                          addressController.text,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: cityController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Città',
                      hintText: 'Inserisci la città',
                    ),
                    onChanged: (value) {
                      BlocProvider.of<ManageAccountBloc>(context).add(
                        ChangingUserInfoEvent(
                          cityController.text,
                          phoneNumberController.text,
                          addressController.text,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      labelText: 'Indirizzo',
                      hintText: 'Inserisci il tuo indirizzo',
                    ),
                    onChanged: (value) {
                      BlocProvider.of<ManageAccountBloc>(context).add(
                        ChangingUserInfoEvent(
                          cityController.text,
                          phoneNumberController.text,
                          addressController.text,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          clearController();
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
                              "Indietro",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        child:
                            BlocBuilder<ManageAccountBloc, ManageAccountState>(
                          builder: (context, state) {
                            if (state is ChangingUserInfoState) {
                              return BlocListener<ManageAccountBloc,
                                  ManageAccountState>(
                                listener: (context, state) {
                                  if (state is UserInfoChanged) {
                                    if (userRole.toString() ==
                                        'ROLE_EMPLOYEE') {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              homePageUserRoute);
                                    } else if (userRole.toString() ==
                                        'ROLE_COMPANY_MANAGER') {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              homePageManagerRoute);
                                    } else if (userRole.toString() ==
                                        'ROLE_HEADQUARTERS_RECEPTIONIST') {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              homePageReceptionistRoute);
                                    } else {
                                      clearController();
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
                                  } else if (state is ManageAccountError) {
                                    clearController();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Errore'),
                                          content: Text(state.errorMessage),
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
                                child: TextButton(
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    BlocProvider.of<ManageAccountBloc>(context)
                                        .add(
                                      ChangeUserInfoSubmittedEvent(
                                        cityController.text,
                                        addressController.text,
                                        "+39 " + phoneNumberController.text,
                                        userToken.toString(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Salva',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return TextButton(
                                onPressed: null,
                                child: Text(
                                  'Salva',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            }
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
      ),
    );
  }
}
