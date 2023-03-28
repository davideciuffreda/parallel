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
      if (event.username == 'admin' && event.password == 'adminpass') {
        emit(LoginAdminState());
      } else if (event.username == 'user' && event.password == 'userpass') {
        emit(LoginUserState());
      } else {
        emit(LoginErrorState("Username o passowrd errati!"));
      }
    });

    on<LogoutEvent>((event, emit) {
      emit(LogoutState());
    });
  }
}
