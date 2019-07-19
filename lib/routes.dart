import 'package:event_qr_check/screens/event_checker/event_checker.dart';
import 'package:event_qr_check/screens/home/home.dart';
import 'package:flutter/material.dart';

class Router {
  static Map<String, dynamic> params = Map();
  
  static var routes = <String, WidgetBuilder> {
    '/home': (_) => HomePage(),
    '/event_checker': (_) => EventChecker()
  };
}