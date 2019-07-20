import 'package:barcode_scan/barcode_scan.dart';
import 'package:event_qr_check/models/attendant.dart';
import 'package:event_qr_check/models/event.dart';
import 'package:event_qr_check/screens/event_checker/widgets/corret_wrong_overlay.dart';
import 'package:event_qr_check/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../routes.dart';

class EventChecker extends StatefulWidget {
  final Event _event;
  final EventService _eventService;

  EventChecker(): 
    this._event = Router.params['event'],
    this._eventService = EventService();

  @override
  _EventCheckerState createState() => _EventCheckerState();
}

class _EventCheckerState extends State<EventChecker> {
  bool showOverlay = false;
  CorrectWrongOverlay overlay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: RaisedButton(
                child: Text('Scan QR Code'),
                onPressed: scan,
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
              ),
            ),
          ],
        ),
        showOverlay 
          ? this.overlay 
          : Container() 
      ],
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      bool correct = await _checkAttendant(barcode);
      this.overlay = CorrectWrongOverlay(
        correct,
        correct ? '' : 'Already assited... Cheater :)',
        onOverlayClosed
      );
      setState(() {
        this.showOverlay = true; 
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.overlay = CorrectWrongOverlay(
            false,
            'Cammera Access Denied',
            this.onOverlayClosed
          );
          this.showOverlay = true;
        });
      } else {
        setState(() { 
          this.overlay = CorrectWrongOverlay(
            false,
            'Unknown error: $e',
            this.onOverlayClosed
          );
          this.showOverlay = true;
        });
      }
    } on FormatException {
      print('User has not scanned anything');
    } catch (e) {
      setState(() { 
        this.overlay = CorrectWrongOverlay(
          false,
          'Unknown error: $e',
          this.onOverlayClosed
        );
        this.showOverlay = true;
      });    
    }
  }

  void onOverlayClosed() {
    setState(() {
      showOverlay = false;
    });
  }

  Future<bool> _checkAttendant(String barcode) async {
    Attendant attendant = Attendant.fromQR(barcode);
    if (await widget._eventService.alreadyAssisted(widget._event, attendant)) {
      return false;
    } 

    await widget._eventService.registerAttendant(widget._event, attendant);
    return true;
  }
}