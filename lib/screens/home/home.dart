import 'package:event_qr_check/models/event.dart';
import 'package:event_qr_check/screens/home/widgets/event.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EventButton(
          Event(1, 'Esmorzar'), 
          Color.fromARGB(255, 243, 229, 245)
        ),
        EventButton(
          Event(2, 'Dinar'), 
          Color.fromARGB(255, 225, 190, 231)
        ),
        EventButton(
          Event(2, 'Sopar'), 
          Color.fromARGB(255, 206, 147, 216)
        ),
      ],
    );
  }
}