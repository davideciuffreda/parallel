import 'package:flutter/material.dart';
import 'package:parallel/pages/home/home_page_manager.dart';
import 'package:parallel/routing/app_router.dart';
import 'package:parallel/pages/home/home_page_user.dart';

void main() {
  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
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
        child: HomePageManager(),
      ),
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
