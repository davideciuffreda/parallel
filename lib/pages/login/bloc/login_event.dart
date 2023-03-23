part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginTextChangedEvent extends LoginEvent {
  final String usernameValue;
  final String passwordValue;

  LoginTextChangedEvent(
    this.usernameValue,
    this.passwordValue,
  );
}

class LoginSubmittedEvent extends LoginEvent {
  final String username;
  final String password;

  LoginSubmittedEvent(
    this.username,
    this.password,
  );
}

class LogoutEvent extends LoginEvent {}
