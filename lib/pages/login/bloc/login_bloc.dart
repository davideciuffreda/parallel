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
      } else if (event.usernameValue == 'admin') {
        emit(LoginAdminState());
      } else if (event.usernameValue == 'user') {
        emit(LoginUserState());
      } else {
        emit(LoginErrorState("Username o passowrd errati!"));
      }
    });

    on<LoginSubmittedEvent>((event, emit) {
      emit(LoginLoadingState());
    });

    on<LogoutEvent>((event, emit) {
      emit(LogoutState());
    });
  }
}
