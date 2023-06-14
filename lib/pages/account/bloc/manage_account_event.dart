part of 'manage_account_bloc.dart';

abstract class ManageAccountEvent {}

class ChangingPasswordEvent extends ManageAccountEvent {
  final String oldPwd;
  final String newPwd;
  final String confirmPwd;

  ChangingPasswordEvent(
    this.oldPwd,
    this.newPwd,
    this.confirmPwd,
  );
}

class ChangePasswordSubmittedEvent extends ManageAccountEvent {
  final String oldPwd;
  final String newPwd;
  final String confirmPwd;
  final String token;

  ChangePasswordSubmittedEvent(
    this.oldPwd,
    this.newPwd,
    this.confirmPwd,
    this.token,
  );
}
