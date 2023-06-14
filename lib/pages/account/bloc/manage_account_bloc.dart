import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parallel/core/repositories/main_repository.dart';

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

        if (value.toString() == 'done') {
          emit(PasswordChanged());
        } else {
          emit(ManageAccountError(
              "La password nuova deve contenere almeno 8 caratteri, di cui almeno una lettera maiuscola, una lettera minuscola, un numero, un carattere speciale tra @#\$%^&+=!"));
        }
      });
    });
  }
}
