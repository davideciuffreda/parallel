part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginTextChangedEvent extends LoginEvent {
  final String emailValue;
  final String passwordValue;

  LoginTextChangedEvent(
    this.emailValue,
    this.passwordValue,
  );
}

class LoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmittedEvent(
    this.email,
    this.password,
  );
}

class LogoutEvent extends LoginEvent {}
