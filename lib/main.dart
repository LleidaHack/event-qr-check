import 'package:event_qr_check/routes.dart';
import 'package:event_qr_check/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

main() async {
  await SystemChrome.setPreferredOrientations([
    //Blocks the device orientation
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(fontFamily: 'Montserrat'),
      routes: Router.routes,
    ),
  );
}
