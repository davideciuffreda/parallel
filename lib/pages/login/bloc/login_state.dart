part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginValidState extends LoginState {}

class LoginUserState extends LoginState {}

class LoginAdminState extends LoginState {}

class LoginErrorState extends LoginState {
  final String errorMessage;

  LoginErrorState(this.errorMessage);
}

class LoginLoadingState extends LoginState {}

class LogoutState extends LoginState {}