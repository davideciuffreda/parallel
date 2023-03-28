import 'dart:async';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:parallel/app.dart';

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