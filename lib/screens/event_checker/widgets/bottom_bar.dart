import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final Function callback;

  const BottomBar({Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FancyBottomNavigation(
        tabs: [
            TabData(iconData: Icons.center_focus_weak, title: "QR Scan"),
            TabData(iconData: Icons.person, title: "Attendants")
        ],
        circleColor: Color.fromARGB(255, 206, 147, 216),
        inactiveIconColor: Color.fromARGB(255, 155, 109, 163),
        barBackgroundColor: Color.fromARGB(255, 243, 229, 245),
        onTabChangedListener: callback
    );
  }
}