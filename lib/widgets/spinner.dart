import 'package:flutter/material.dart';

class SpinnerLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Color.fromARGB(255, 243, 229, 245),
      child: Center(
        child: Container(
          width: 50.0,
          height: 50.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent)
          )
        )
      )
    );
  }
}