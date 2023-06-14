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

class EditPasswordPage extends StatefulWidget {
  @override
  State<EditPasswordPage> createState() => _EditPasswordPage();
}

class _EditPasswordPage extends State<EditPasswordPage> {
  TextEditingController currentPwdController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();
  TextEditingController confirmNewPwdController = TextEditingController();

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

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getUserRole();
  }

  void getUserRole() {
    String? storedUserRole = sharedPreferences.getString('userRole');
    setState(() {
      userRole = storedUserRole;
    });
  }

  void getToken() async {
    String? storedToken = await storage.read(key: 'userToken');
    setState(() {
      userToken = storedToken;
    });
  }

  void cleanController() {
    currentPwdController.clear();
    newPwdController.clear();
    confirmNewPwdController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Modifica password"),
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
                    controller: currentPwdController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Password attuale',
                      hintText: 'Inserisci la password corrente',
                    ),
                    onChanged: (value) {
                      BlocProvider.of<ManageAccountBloc>(context).add(
                        ChangingPasswordEvent(
                          currentPwdController.text,
                          newPwdController.text,
                          confirmNewPwdController.text,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: newPwdController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Nuova password',
                      hintText: 'Inserisci la password che vuoi impostare',
                    ),
                    onChanged: (value) {
                      BlocProvider.of<ManageAccountBloc>(context).add(
                        ChangingPasswordEvent(
                          currentPwdController.text,
                          newPwdController.text,
                          confirmNewPwdController.text,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: confirmNewPwdController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Conferma password',
                      hintText:
                          'Inserisci di nuovo la password che vuoi impostare',
                    ),
                    onChanged: (value) {
                      BlocProvider.of<ManageAccountBloc>(context).add(
                        ChangingPasswordEvent(
                          currentPwdController.text,
                          newPwdController.text,
                          confirmNewPwdController.text,
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
                          currentPwdController.clear();
                          confirmNewPwdController.clear();
                          newPwdController.clear();
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
                            if (state is ChangingPasswordState) {
                              return BlocListener<ManageAccountBloc,
                                  ManageAccountState>(
                                listener: (context, state) {
                                  if (state is PasswordChanged) {
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
                                      cleanController();
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
                                    cleanController();
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
                                      ChangePasswordSubmittedEvent(
                                        currentPwdController.text,
                                        newPwdController.text,
                                        confirmNewPwdController.text,
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
