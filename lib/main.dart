import 'package:event_qr_check/routes.dart';
import 'package:event_qr_check/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

main() => runApp(
  MaterialApp(
    home: SplashScreen(),
    theme: ThemeData(fontFamily: 'Montserrat'),
    routes: Router.routes,
  )
);