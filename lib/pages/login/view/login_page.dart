import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/routing/router_constants.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                padding: EdgeInsets.only(top: 52),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  child: Image.asset("assets/images/sigla.png"),
                ),
              ),
              SizedBox(height: 8),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginErrorState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      onChanged: (value) {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginTextChangedEvent(
                            emailController.text,
                            passwordController.text,
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Inserisci la tua email',
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      onChanged: (value) {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginTextChangedEvent(
                            emailController.text,
                            passwordController.text,
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Inserisci la tua password',
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
                          if (state is LoginReceptionistState) {
                            Navigator.of(context).pushReplacementNamed(
                                homePageReceptionistRoute);
                          } else if (state is LoginUserState) {
                            Navigator.of(context)
                                .pushReplacementNamed(homePageUserRoute);
                          } else if (state is LoginManagerState) {
                            Navigator.of(context)
                                .pushReplacementNamed(homePageManagerRoute);
                          } else if (state is LoginErrorState) {
                            Center(
                              child: Text(
                                state.errorMessage,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            );
                          }
                        },
                        child: TextButton(
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            BlocProvider.of<LoginBloc>(context).add(
                              LoginSubmittedEvent(
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                          },
                          child: Text(
                            'Accedi',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return TextButton(
                        onPressed: null,
                        child: Text(
                          'Accedi',
                          style: TextStyle(
                            color: Colors.grey,
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
