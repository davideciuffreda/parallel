// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

part of 'login_bloc.dart';

abstract class LoginEvent {}

///Evento che segnala che l'utente sta compilando i campi di input
class LoginTextChangedEvent extends LoginEvent {
  final String emailValue;
  final String passwordValue;

  LoginTextChangedEvent(this.emailValue, this.passwordValue);
}

///Evento che segnala che l'utente sta tentando di eseguire il login
class LoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmittedEvent(this.email, this.password);
}

///Evento che segnala che l'utente vuole fare il logout
class LogoutEvent extends LoginEvent {}
