import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/routing/router_constants.dart';

class LoginPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 120,
              width: 120,
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
                            usernameController.text, passwordController.text),
                      );
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter valid username',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    onChanged: (value) {
                      BlocProvider.of<LoginBloc>(context).add(
                        LoginTextChangedEvent(
                            usernameController.text, passwordController.text),
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
            TextButton(
              onPressed: () {},
              child: Text(
                'Password dimenticata?',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              height: 40,
              width: 120,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginAdminState || state is LoginUserState) {
                    return ElevatedButton(
                      onPressed: () {
                        if (state is LoginAdminState) {
                          BlocProvider.of<LoginBloc>(context).add(
                            LoginSubmittedEvent(
                              usernameController.text,
                              passwordController.text,
                            ),
                          );
                          Navigator.of(context)
                              .pushReplacementNamed(homePageReceptionistRoute);
                        } else {
                          BlocProvider.of<LoginBloc>(context).add(
                            LoginSubmittedEvent(
                              usernameController.text,
                              passwordController.text,
                            ),
                          );
                          Navigator.of(context)
                              .pushReplacementNamed(homePageUserRoute);
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 22,
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
    );
  }
}
