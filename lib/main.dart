import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel/routing/app_router.dart';

import 'package:parallel/pages/account/account_page.dart';
import 'package:parallel/pages/bookings/bookings_page.dart';
import 'package:parallel/pages/events/events_page.dart';
import 'package:parallel/pages/headquarters/favorites_headquarters_page.dart';
import 'package:parallel/pages/forum/forum_page.dart';
import 'package:parallel/pages/headquarters/headquarters_page.dart';
import 'package:parallel/pages/home/home_page_user.dart';
import 'package:parallel/pages/login/login_page.dart';
import 'package:parallel/pages/notifications/notifications_page.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parallel',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
      ),
      home: SafeArea(
        child: HomePageUser(),
      ),
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
