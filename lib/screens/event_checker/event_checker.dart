import 'package:barcode_scan/barcode_scan.dart';
import 'package:event_qr_check/models/attendant.dart';
import 'package:event_qr_check/models/event.dart';
import 'package:event_qr_check/screens/event_checker/widgets/attendants_page.dart';
import 'package:event_qr_check/screens/event_checker/widgets/bottom_bar.dart';
import 'package:event_qr_check/screens/event_checker/widgets/corret_wrong_overlay.dart';
import 'package:event_qr_check/screens/event_checker/widgets/loading_overlay.dart';
import 'package:event_qr_check/screens/event_checker/widgets/scan_page.dart';
import 'package:event_qr_check/services/event_service.dart';
import 'package:event_qr_check/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../routes.dart';

class EventChecker extends StatefulWidget {
  final Event _event;
  final EventService _eventService;
  final UserService _userService;

  EventChecker()
      : this._event = Router.params['event'],
        this._eventService = EventService(),
        this._userService = UserService();

  @override
  _EventCheckerState createState() => _EventCheckerState();
}

class _EventCheckerState extends State<EventChecker> {
  bool showOverlay = false;
  CorrectWrongOverlay overlay;

  bool loading = false;

  List<Widget> pages;

  int currentPage = 0;

  @override
  void initState() {
    pages = [
      ScanPage(event: widget._event, scanFunction: scan),
      AttendantsPage(
        event: widget._event,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Scaffold(
              body: pages[currentPage],
              bottomNavigationBar: BottomBar(callback: (pos) {
                setState(() {
                  this.currentPage = pos;
                });
              })),
          showOverlay ? this.overlay : Container(),
          loading ? LoadingOverlay() : Container()
        ],
      ),
    );
  }

  Future scan() async {
    try {
      // Scan QR code and get the encoded string
      final String barcode = await BarcodeScanner.scan();

      setState(() {
        loading = true;
      });
      // Check attendant premissions
      var userSnapshot =
          await widget._userService.getUserSnapshotFromQR(barcode);
      final attendant = Attendant.fromSnapshot(userSnapshot);
      final correct = await _checkAttendant(attendant);
      final message =
          correct ? '${attendant.nickname}' : 'Already assited... Cheater :)';

      // Show the overlay
      this._setOverlay(correct, message);
      setState(() {
        this.loading = false;
        this.showOverlay = true;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        this._setOverlay(false, 'Cammera Access Denied');
        setState(() {
          this.loading = false;
          this.showOverlay = true;
        });
      } else {
        this._setOverlay(false, 'Unknown error: $e');
        setState(() {
          this.loading = false;
          this.showOverlay = true;
        });
      }
    } on FormatException catch (e) {
      print('User has not scanned anything');
      print('$e');
    } catch (e) {
      this._setOverlay(false, 'Unknown error: $e');
      setState(() {
        this.loading = false;
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

  Future<bool> _checkAttendant(Attendant attendant) async {
    // Check if the person who is trying to attend
    // has already been there
    final assisted =
        await widget._eventService.alreadyAssisted(widget._event, attendant);

    // If already been there, forbid the access
    if (assisted) return false;

    // Else register the attendant
    await widget._eventService.registerAttendant(widget._event, attendant);
    return true;
  }

  void _setOverlay(bool isCorrect, String message) {
    this.overlay =
        CorrectWrongOverlay(isCorrect, message, this.onOverlayClosed);
  }
}
