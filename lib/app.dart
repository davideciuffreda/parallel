import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parallel/core/repositories/main_repository.dart';
import 'package:parallel/pages/events/cubit/event_cubit.dart';
import 'package:parallel/pages/headquarters/cubit/headquarter_cubit.dart';
import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/pages/login/view/login_page.dart';
import 'package:parallel/routing/app_router.dart';

/// Global navigator to retrieve the context for the controllers
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class AppInitializer extends StatelessWidget {
  //Defining the Repositories
  late MainRepository mainRepository;
  //Defining the Blocs/Cubits
  late HeadquarterCubit headquarterCubit;
  late EventCubit eventCubit;
  late LoginBloc loginBloc;

  AppInitializer() {
    //Repositories init
    mainRepository = MainRepository();
    //Bloc or Cubit init
    headquarterCubit = HeadquarterCubit(mainRepository);
    eventCubit = EventCubit(mainRepository);
    loginBloc = LoginBloc();
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
        BlocProvider<HeadquarterCubit>(
          create: (context) => headquarterCubit,
        ),
        BlocProvider<EventCubit>(
          create: (context) => eventCubit,
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
      create: (context) => LoginBloc(),
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
