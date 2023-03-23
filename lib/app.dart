import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parallel/pages/login/bloc/login_bloc.dart';
import 'package:parallel/pages/login/view/login_page.dart';
import 'package:parallel/routing/app_router.dart';

/// Global navigator to retrieve the context for the controllers
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class AppInitializer extends StatelessWidget {
  //Defining the Repositories
  //Defining the Blocs/Cubits

  AppInitializer() {
    //Repositories init
    //Bloc or Cubit init
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return BlocProvider(
      create: (context) => LoginBloc(),
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
        title: "Parallel",
        navigatorKey: navigatorKey,
        home: LoginPage(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
