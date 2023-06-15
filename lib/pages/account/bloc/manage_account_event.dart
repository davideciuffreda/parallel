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

class ChangingUserInfoEvent extends ManageAccountEvent {
  final String city;
  final String address;
  final String phoneNumber;

  ChangingUserInfoEvent(
    this.city,
    this.address,
    this.phoneNumber,
  );
}

class ChangeUserInfoSubmittedEvent extends ManageAccountEvent {
  final String city;
  final String address;
  final String phoneNumber;
  final String token;

  ChangeUserInfoSubmittedEvent(
    this.city,
    this.address,
    this.phoneNumber,
    this.token,
  );
}
