part of 'manage_account_bloc.dart';

abstract class ManageAccountState {}

class ManageAccountInitial extends ManageAccountState {}

class PasswordChanged extends ManageAccountState {}

class UserInfoChanged extends ManageAccountState {}

class ManageAccountError extends ManageAccountState {
  final String errorMessage;

  ManageAccountError(this.errorMessage);
}

class ChangingPasswordState extends ManageAccountState {}

class ChangingUserInfoState extends ManageAccountState {}
