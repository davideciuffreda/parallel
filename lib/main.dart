import 'dart:async';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:parallel/routing/app_router.dart';
import 'package:parallel/app.dart';
import 'package:parallel/pages/home/home_page_user.dart';
import 'package:parallel/pages/home/home_page_receptionist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(AppInitializer()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}