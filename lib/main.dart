import 'package:event_qr_check/routes.dart';
import 'package:event_qr_check/screens/home/home.dart';
import 'package:flutter/material.dart';

main() => runApp(
  MaterialApp(
    home: HomePage(),
    theme: ThemeData(fontFamily: 'Montserrat'),
    routes: Router.routes,
  )
);