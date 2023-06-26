// Copyright - 2023 - Ciuffreda Davide
//
// Use of this source code is governed by an
// MIT-style license that can be found at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parallel/app.dart';

void main() async {
  ///Controllo che tutti i widget siano inizializzati correttamente prima di 
  ///eseguire l'applicazione
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  ///runZoneGuarded() garantiscce che eventuali errori che si verificano
  ///durante l'esecuzione siano gestiti in modo controllato
  runZonedGuarded(
    () => runApp(AppInitializer()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}