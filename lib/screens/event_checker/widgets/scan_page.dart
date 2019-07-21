import 'package:event_qr_check/models/event.dart';
import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  final Event event;
  final Function scanFunction;

  const ScanPage({
    Key key, 
    this.scanFunction,
    this.event
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: FlatButton(
            child: Icon(
              Icons.chevron_left,
              size: 60.0,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ),   
        Padding(padding: EdgeInsets.all(20.0),),     
        Icon(
          Icons.center_focus_weak,
          size: 180.0,
        ),
        Padding(padding: EdgeInsets.all(30.0),),
        Text(
          this.event.name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 80.0),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 80.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Scan QR Code',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
            onPressed: scanFunction,
            color: Color.fromARGB(255, 225, 190, 231),
            textColor: Colors.white,
            splashColor: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}