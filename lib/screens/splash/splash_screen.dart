import 'dart:async';

import 'package:event_qr_check/screens/home/home.dart';
import 'package:event_qr_check/utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() { 
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        FadingRoute(builder: (context) => HomePage()),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 185, 147, 214),
            Color.fromARGB(255, 140, 166, 219),
          ],
        ), 
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Align(
              alignment: FractionalOffset.center,
              child: Image(image: AssetImage('images/logo-hackeps.png')),
            ),
          ),
          Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Image(image: AssetImage('images/skyline.png')),
            )
          )
        ],
      ),
    );
  }
}