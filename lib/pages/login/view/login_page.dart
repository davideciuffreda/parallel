import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/routing/router_constants.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Remove the keyboard when the user press anywhere on the screen
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 170,
                width: 170,
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
              SizedBox(height: 10),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginErrorState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      onChanged: (value) {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginTextChangedEvent(
                            usernameController.text,
                            passwordController.text,
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        hintText: 'Enter valid username',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      onChanged: (value) {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginTextChangedEvent(
                            usernameController.text,
                            passwordController.text,
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter your password',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoadingState) {
                      return BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginAdminState) {
                            Navigator.of(context).pushReplacementNamed(
                              homePageReceptionistRoute,
                            );
                          } else if (state is LoginUserState) {
                            Navigator.of(context).pushReplacementNamed(
                              homePageUserRoute,
                            );
                          } else if (state is LoginManagerState) {
                            Navigator.of(context).pushReplacementNamed(
                              homePageManagerRoute,
                            );
                          }
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            BlocProvider.of<LoginBloc>(context).add(
                              LoginSubmittedEvent(
                                usernameController.text,
                                passwordController.text,
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: null,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
