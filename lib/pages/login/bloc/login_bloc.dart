import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parallel/core/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<LoginTextChangedEvent>((event, emit) {
      if (event.emailValue == '') {
        emit(LoginErrorState("Please, enter a valid email address!"));
      } else if (event.passwordValue.length < 3) {
        emit(LoginErrorState("Please, enter a valid password!"));
      } else {
        emit(LoginLoadingState());
      }
    });

    /* on<LoginSubmittedEvent>((event, emit) {
      if (event.username == 'receptionist' && event.password == 'receptionistpass') {
        emit(LoginAdminState());
      } else if (event.username == 'user' && event.password == 'userpass') {
        emit(LoginUserState());
      } else if (event.username == 'manager' && event.password == 'managerpass') {
        emit(LoginManagerState());
      } else {
        emit(LoginErrorState("Username o passowrd errati!"));
      }
    }); */

    on<LoginSubmittedEvent>((event, emit) async {
      await authRepository.tryLogIn(event.email, event.password).then((token) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

        print("[DecodedToken] " + decodedToken.toString());
        print("[Token]: " + token);

        if (decodedToken['role'] == "ROLE_ADMIN") {
          emit(LoginAdminState());
        } else if (decodedToken['role'] == "ROLE_COMPANY_MANAGER") {
          emit(LoginManagerState());
        } else if (decodedToken['role'] == "ROLE_HEADQUARTERS_RECEPTIONIST") {
          emit(LoginAdminState());
        } else if (decodedToken['role'] == "ROLE_USER") {
          emit(LoginUserState());
        } else {
          emit(LoginErrorState("Username o passowrd errati!"));
        }
      });
    });

    ///Logout the user
    on<LogoutEvent>((event, emit) {
      emit(LogoutState());
    });
  }
}
