import 'package:bloc/bloc.dart';
import 'package:parallel/core/repositories/main_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'manage_account_event.dart';
part 'manage_account_state.dart';

class ManageAccountBloc extends Bloc<ManageAccountEvent, ManageAccountState> {
  final MainRepository mainRepository;

  ManageAccountBloc(this.mainRepository) : super(ManageAccountInitial()) {
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

    on<ChangePasswordSubmittedEvent>((event, emit) async {
      //print("[OldPwd]: " + event.oldPwd);
      //print("[NewPwd]: " + event.newPwd);
      //print("[ConPwd]: " + event.confirmPwd);
      //print("[Token]: " + event.token);

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

    on<ChangingUserInfoEvent>((event, emit) {
      if (event.city.isEmpty ||
          event.address.isEmpty ||
          event.phoneNumber.isEmpty) {
        emit(ManageAccountError("Compilare tutti i campi!"));
      } else {
        emit(ChangingUserInfoState());
      }
    });

    on<ChangeUserInfoSubmittedEvent>((event, emit) async {
      //print("[city]: " + event.city);
      //print("[address]: " + event.address);
      //print("[phoneNumber]: " + event.phoneNumber);
      //print("[Token]: " + event.token);
      final prefs = await SharedPreferences.getInstance();

      await mainRepository
          .changeUserInfo(
        event.city,
        event.address,
        event.phoneNumber,
        event.token,
      )
          .then((value) {
        // print("[Value]: " + value.toString());

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
