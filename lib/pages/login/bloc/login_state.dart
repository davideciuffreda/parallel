// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginValidState extends LoginState {}

class LoginUserState extends LoginState {}

class LoginReceptionistState extends LoginState {}

class LoginManagerState extends LoginState {}

class LoginErrorState extends LoginState {
  final String errorMessage;

  LoginErrorState(this.errorMessage);
}

class LoginLoadingState extends LoginState {}

class LogoutState extends LoginState {}