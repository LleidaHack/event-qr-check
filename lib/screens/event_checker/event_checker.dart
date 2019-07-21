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
      // Scan QR code and get the encoded string
      final String barcode = await BarcodeScanner.scan();

      // Check attendant premissions
      final correct = await _checkAttendant(barcode);
      final message = correct ? '' : 'Already assited... Cheater :)';

      // Show the overlay
      this._setOverlay(correct, message);
      setState(() {
        this.showOverlay = true; 
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        this._setOverlay(false, 'Cammera Access Denied');
        setState(() {
          this.showOverlay = true;
        });
      } else {
        this._setOverlay(false, 'Unknown error: $e');
        setState(() { 
          this.showOverlay = true;
        });
      }
    } on FormatException {
      print('User has not scanned anything');
    } catch (e) {
      this._setOverlay(false, 'Unknown error: $e');
      setState(() { 
        this.showOverlay = true;
      });    
    }
  }

  void onOverlayClosed() {
    // Callback to close the overlay
    setState(() {
      showOverlay = false;
    });
  }

  Future<bool> _checkAttendant(String barcode) async {
    // Check if the person who is trying to attend
    // has already been there
    final attendant = Attendant.fromQR(barcode);
    final assisted = await widget._eventService.alreadyAssisted(widget._event, attendant); 
    
    // If already been there, forbid the access
    if (assisted)
      return false;

    // Else register the attendant
    await widget._eventService.registerAttendant(widget._event, attendant);
    return true;
  }

  void _setOverlay(bool isCorrect, String message) {
    this.overlay = CorrectWrongOverlay(
      isCorrect,
      message,
      this.onOverlayClosed
    );
  }
}