import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginTextChangedEvent>((event, emit) {
      if (event.usernameValue == '') {
        emit(LoginErrorState("Please, enter a valid username!"));
      } else if (event.passwordValue.length < 8) {
        emit(LoginErrorState("Please, enter a valid password!"));
      } else {
        emit(LoginLoadingState());
      }
    });

    on<LoginSubmittedEvent>((event, emit) {
      if (event.username == 'receptionist' && event.password == 'receptionistpass') {
        emit(LoginAdminState());
      } else if (event.username == 'user' && event.password == 'userpass') {
        emit(LoginUserState());
      } else if (event.username == 'manager' && event.password == 'managerpass') {
        emit(LoginManagerState());
      } else {
        emit(LoginErrorState("Username o passowrd errati!"));
      }
    });

    ///Logout the user
    on<LogoutEvent>((event, emit) {
      emit(LogoutState());
    });
  }
}
