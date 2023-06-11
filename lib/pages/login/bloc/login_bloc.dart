import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parallel/core/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final storage = FlutterSecureStorage();
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<LoginTextChangedEvent>((event, emit) {
      if (event.emailValue == '') {
        emit(LoginErrorState("Inserire un indirizzo email valido..."));
      } else if (event.passwordValue.length < 4) {
        emit(LoginErrorState("Inserire una password valida..."));
      } else {
        emit(LoginLoadingState());
      }
    });

    on<LoginSubmittedEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      await authRepository
          .tryLogIn(event.email, event.password)
          .then((token) async {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

        await saveToken(token, decodedToken, prefs);

        //print("[DecodedToken] " + decodedToken.toString());
        //print("[TokenBLoC]: " + token);

        if (decodedToken['role'] == "ROLE_ADMIN") {
          emit(LoginAdminState());
        } else if (decodedToken['role'] == "ROLE_COMPANY_MANAGER") {
          emit(LoginManagerState());
        } else if (decodedToken['role'] == "ROLE_HEADQUARTERS_RECEPTIONIST") {
          emit(LoginReceptionistState());
        } else if (decodedToken['role'] == "ROLE_EMPLOYEE") {
          emit(LoginUserState());
        } else {
          emit(LoginErrorState("Username o password errati!"));
        }
      });
    });

    //Logout the user
    on<LogoutEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      await authRepository
          .tryLogOut(await storage.read(key: 'userToken') as String);

      await removeSavedInfo(prefs);

      emit(LogoutState());
    });
  }

  Future<void> saveToken(String token, Map<String, dynamic> decodedToken,
      SharedPreferences prefs) async {
    //memorizzazione del token codificato nel Flutter Secure Storage
    String key = 'userToken';
    String value = token;
    await storage.write(key: key, value: value);

    //memorizzazione di email, nome e cognome dell'utente nelle SharedPreferences
    await prefs.setString('email', decodedToken['email']);
    await prefs.setString('firstName', decodedToken['firstName']);
    await prefs.setString('lastName', decodedToken['lastName']);
  }

  Future<void> removeSavedInfo(SharedPreferences prefs) async {
    //rimozione delle userInfo salvate nel FSS e nelle SP
    await storage.delete(key: 'token');
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    await prefs.remove('email');
  }
}
