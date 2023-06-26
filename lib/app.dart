// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/core/repositories/auth_repository.dart';

import 'package:parallel/core/repositories/main_repository.dart';
import 'package:parallel/pages/access_log/cubit/access_log_cubit.dart';
import 'package:parallel/pages/account/bloc/manage_account_bloc.dart';
import 'package:parallel/pages/bookings/bloc/booking_bloc.dart';
import 'package:parallel/pages/events/cubit/event_cubit.dart';
import 'package:parallel/pages/headquarters/cubit/headquarter_cubit.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/pages/login/view/login_page.dart';
import 'package:parallel/routing/app_router.dart';

///Navigatore globale per recuperare il context
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class AppInitializer extends StatelessWidget {
  ///Definizione delle repository
  late MainRepository mainRepository;
  late AuthRepository authRepository;
  ///Definizione dei BLoC/Cubit
  late LoginBloc loginBloc;
  late HeadquarterCubit headquarterCubit;
  late ManageAccountBloc manageAccountBloc;
  late EventCubit eventCubit;
  late AccessLogCubit accessLogCubit;
  late BookingBloc addBookingBloc;

  AppInitializer() {
    ///Inizializzazione delle repository
    mainRepository = MainRepository();
    authRepository = AuthRepository();
    ///Inizializzazione dei BLoC e dei Cubit
    loginBloc = LoginBloc(authRepository);
    manageAccountBloc = ManageAccountBloc(mainRepository);
    headquarterCubit = HeadquarterCubit(mainRepository);
    eventCubit = EventCubit(mainRepository);
    accessLogCubit = AccessLogCubit(mainRepository);
    addBookingBloc = BookingBloc(mainRepository);
  }

  @override
  Widget build(BuildContext context) {
    ///Imposta l'orientamento del dispositivo in modo tale che l'app dovrebbe
    ///essere visualizzata solo in modalità "ritratto" con l'orientamento
    ///verso l'alto
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    ///'MultiBlocProvider' permette la creazione di BlocProvider
    ///in modo da poterli utilizzare in diverse parti dell'app
    ///senza doverli creare manualmente ogni volta
    return MultiBlocProvider(
      providers: [
        ///BLoC dedicato al Login
        BlocProvider<LoginBloc>(
          create: (context) => loginBloc,
        ),
        ///BLoC dedicato alla gestione dell'account
        BlocProvider<ManageAccountBloc>(
          create: (context) => manageAccountBloc,
        ),
        ///BLoC dedicato alle operazioni di prenotazione di una postazione
        BlocProvider<BookingBloc>(
          create: (context) => addBookingBloc,
        ),
        ///BLoC dedicato alle operazioni riguardanti una sede
        BlocProvider<HeadquarterCubit>(
          create: (context) => headquarterCubit,
        ),
        ///BLoC dedicato agli eventi
        BlocProvider<EventCubit>(
          create: (context) => eventCubit,
        ),
        ///BLoC dedicato alle operazioni a disposizione del receptionist
        BlocProvider<AccessLogCubit>(
          create: (context) => accessLogCubit,
        ),
      ],
      child: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ///Inizializzazione della classe che viene utilizzata
  ///per definire le routes e la navigazione all'interno dell'app
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(AuthRepository()),
      child: MaterialApp(
        ///Nasconde il banner 'Debug' che apparirebbe in alto a destra
        debugShowCheckedModeBanner: false,
        title: "Parallel",
        navigatorKey: navigatorKey,
        home: LoginPage(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
