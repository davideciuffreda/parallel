// ignore_for_file: must_be_immutable

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

//Global navigator to retrieve the context for the controllers
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class AppInitializer extends StatelessWidget {
  //Definizione delle repository
  late MainRepository mainRepository;
  late AuthRepository authRepository;
  //Definizione dei BLoC/Cubit
  late LoginBloc loginBloc;
  late HeadquarterCubit headquarterCubit;
  late ManageAccountBloc manageAccountBloc;
  late EventCubit eventCubit;
  late AccessLogCubit accessLogCubit;
  late BookingBloc addBookingBloc;

  AppInitializer() {
    //Repositories init
    mainRepository = MainRepository();
    authRepository = AuthRepository();
    //Bloc or Cubit init
    loginBloc = LoginBloc(authRepository);
    manageAccountBloc = ManageAccountBloc(mainRepository);
    headquarterCubit = HeadquarterCubit(mainRepository);
    eventCubit = EventCubit(mainRepository);
    accessLogCubit = AccessLogCubit(mainRepository);
    addBookingBloc = BookingBloc(mainRepository);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => loginBloc,
        ),
        BlocProvider<ManageAccountBloc>(
          create: (context) => manageAccountBloc,
        ),
        BlocProvider<BookingBloc>(
          create: (context) => addBookingBloc,
        ),
        BlocProvider<HeadquarterCubit>(
          create: (context) => headquarterCubit,
        ),
        BlocProvider<EventCubit>(
          create: (context) => eventCubit,
        ),
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
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(AuthRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Parallel",
        navigatorKey: navigatorKey,
        home: LoginPage(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
