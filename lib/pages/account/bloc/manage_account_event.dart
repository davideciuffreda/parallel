// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

part of 'manage_account_bloc.dart';

abstract class ManageAccountEvent {}

///Evento che segnala che l'utente sta compilando i campi per il cambio password
class ChangingPasswordEvent extends ManageAccountEvent {
  final String oldPwd;
  final String newPwd;
  final String confirmPwd;

  ChangingPasswordEvent(this.oldPwd, this.newPwd, this.confirmPwd);
}

///Evento che segnala che l'utente ha tentato il cambio password
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

///Evento che segnala che l'utente sta compilando i campi per il cambio dati
class ChangingUserInfoEvent extends ManageAccountEvent {
  final String city;
  final String address;
  final String phoneNumber;

  ChangingUserInfoEvent(this.city, this.address, this.phoneNumber);
}

///Evento che segnala che l'utente ha tentato il cambio dati
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
