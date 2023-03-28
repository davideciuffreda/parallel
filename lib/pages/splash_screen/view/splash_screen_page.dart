import 'package:flutter/material.dart';

/// Simple splashscreen UI with the logo on the center
class SplashScreenPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/splash.png',
          width: MediaQuery.of(context).size.width * 0.785,
        ),
      ),
    );
  }
}