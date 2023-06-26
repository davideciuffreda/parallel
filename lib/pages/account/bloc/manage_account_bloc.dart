// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:parallel/core/repositories/main_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'manage_account_event.dart';
part 'manage_account_state.dart';

///Utente di destinazione: ANY
class ManageAccountBloc extends Bloc<ManageAccountEvent, ManageAccountState> {
  final MainRepository mainRepository;

  ManageAccountBloc(this.mainRepository) : super(ManageAccountInitial()) {
    ///BLoC per il cambio password dedicato alla gestione dei possibili stati
    on<ChangingPasswordEvent>((event, emit) {
      if (event.oldPwd.isEmpty ||
          event.newPwd.isEmpty ||
          event.confirmPwd.isEmpty) {
        emit(ManageAccountError("Compilare tutti i campi!"));
      } else if (event.oldPwd.toString() == event.newPwd.toString()) {
        emit(ManageAccountError(
            "La vecchia e la nuova password non possono essere uguali!"));
      } else if (event.newPwd.toString() != event.confirmPwd.toString()) {
        emit(ManageAccountError("Password non corrispondenti!"));
      } else if (event.newPwd.length < 2) {
        emit(ManageAccountError(
            "La nuova password non rispetta i requisiti necessari!"));
      } else {
        emit(ChangingPasswordState());
      }
    });

    ///BLoC per il cambio password dedicato alla gestione dei possibili stati
    on<ChangePasswordSubmittedEvent>((event, emit) async {
      await mainRepository
          .changePassword(
              event.oldPwd, event.newPwd, event.confirmPwd, event.token)
          .then((value) {
        //print("[Value]: " + value.toString());

        if (value.toString() == 'pwd_changed') {
          emit(PasswordChanged());
        } else {
          emit(ManageAccountError(
              "La password nuova deve contenere almeno 8 caratteri, di cui almeno una lettera maiuscola, una lettera minuscola, un numero, un carattere speciale tra @#\$%^&+=!"));
        }
      });
    });

    ///BLoC per il cambio dati dedicato alla gestione dei possibili stati
    on<ChangingUserInfoEvent>((event, emit) {
      if (event.city.isEmpty ||
          event.address.isEmpty ||
          event.phoneNumber.isEmpty) {
        emit(ManageAccountError("Compilare tutti i campi!"));
      } else {
        emit(ChangingUserInfoState());
      }
    });

    ///BLoC per il cambio dati dedicato alla gestione dei possibili stati
    on<ChangeUserInfoSubmittedEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      await mainRepository
          .changeUserInfo(
        event.city,
        event.address,
        event.phoneNumber,
        event.token,
      )
          .then((value) {

        if (value.toString() == 'info_changed') {
          prefs.setString('city', event.city);
          prefs.setString('address', event.address);
          prefs.setString('phoneNumber', event.phoneNumber);
          emit(UserInfoChanged());
        } else {
          emit(ManageAccountError(
              "Non è stato possibile modificare le informazioni, controllare di aver compilato correttamente i campi."));
        }
      });
    });
  }
}
