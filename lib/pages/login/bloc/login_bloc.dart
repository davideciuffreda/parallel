import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parallel/core/models/user/user.dart';
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
        emit(LoginErrorState("Inserire un indirizzo mail..."));
      } else if (event.passwordValue.length < 2) {
        emit(LoginErrorState("Inserire una password..."));
      } else {
        emit(LoginLoadingState());
      }
    });

    on<LoginSubmittedEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      await authRepository
          .tryLogIn(event.email, event.password)
          .then((token) async {
        //print("[TokenBLoC]: " + token);

        if (token.isEmpty) {
          emit(LoginErrorState("Username o password errati!"));
        } else {
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

          await authRepository.getUserInfo(token).then((user) {
            saveToken(token, prefs, user);
          });

          //print("[DecodedToken] " + decodedToken.toString());

          switch (decodedToken['role']) {
            case "ROLE_ADMIN":
              emit(LoginReceptionistState());
              break;
            case "ROLE_COMPANY_MANAGER":
              emit(LoginManagerState());
              break;
            case "ROLE_HEADQUARTERS_RECEPTIONIST":
              emit(LoginReceptionistState());
              break;
            case "ROLE_EMPLOYEE":
              emit(LoginUserState());
              break;
            default:
              emit(LoginErrorState("Username o password errati!"));
          }
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

  Future<void> saveToken(
    String token,
    SharedPreferences prefs,
    User user,
  ) async {
    //memorizzazione del token codificato nel Flutter Secure Storage
    String tokenKey = 'userToken';
    String tokenValue = token;
    await storage.write(key: tokenKey, value: tokenValue);

    //memorizzazione dei dati dell'utente nelle SharedPreferences
    await prefs.setString('email', user.email);
    await prefs.setString('role', user.role);
    await prefs.setString('firstName', user.firstName);
    await prefs.setInt('scopeId', user.scopeId);
    await prefs.setString('lastName', user.lastName);
    await prefs.setString('userRole', user.role);
    await prefs.setString('jobPosition', user.jobPosition);
    await prefs.setString('birthDate', user.birthDate.toString());
    await prefs.setString('phoneNumber', user.phoneNumber.toString());
    await prefs.setString('address', user.address);
    await prefs.setString('city', user.city);
  }

  Future<void> removeSavedInfo(SharedPreferences prefs) async {
    //rimozione delle userInfo salvate nel FSS e nelle SP
    await storage.delete(key: 'token');
    await prefs.clear();
  }
}
