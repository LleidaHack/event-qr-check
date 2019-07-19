import 'package:barcode_scan/barcode_scan.dart';
import 'package:event_qr_check/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../routes.dart';

class EventChecker extends StatefulWidget {
  Event _event;
  
  EventChecker() {
    this._event = Router.params['event'];
  }

  @override
  _EventCheckerState createState() => _EventCheckerState();
}

class _EventCheckerState extends State<EventChecker> {
  String barcode = "";
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: scan,
                child: const Text('START CAMERA SCAN')
            ),
          )
          ,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(barcode, textAlign: TextAlign.center,),
          )
          ,
        ],
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}