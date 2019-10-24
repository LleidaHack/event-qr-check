import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_qr_check/models/attendant.dart';
import 'package:event_qr_check/models/event.dart';
import 'package:event_qr_check/services/event_service.dart';
import 'package:event_qr_check/widgets/spinner.dart';
import 'package:flutter/material.dart';

class AttendantsPage extends StatefulWidget {
  final Event event;

  const AttendantsPage({Key key, this.event}) : super(key: key);

  @override
  _AttendantsPageState createState() => _AttendantsPageState();
}

class _AttendantsPageState extends State<AttendantsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
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
            )),
        Icon(
          Icons.person_outline,
          size: 150.0,
          color: Colors.grey,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: EventService()
                .eventAttendantsCollection(widget.event.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return SpinnerLoader();
              return Expanded(
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: Colors.redAccent,
                  child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      children: snapshot.data.documents
                          .map(_buildAttendant)
                          .toList()),
                ),
              );
            })
      ],
    ));
  }

  Widget _buildAttendant(DocumentSnapshot snapshot) {
    final attendant = Attendant.fromSnapshot(snapshot);
    final color = Color.fromARGB(255, 206, 147, 216);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              radius: 30,
              backgroundColor: color,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  attendant.nickname,
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(
                  attendant.email,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: Icon(
              _getIcon(attendant.times),
              color: color,
              size: 40,
            ),
          )
        ],
      ),
    );
  }

  IconData _getIcon(int times) {
    switch (times) {
      case 2:
        return Icons.looks_two;
      case 3:
        return Icons.looks_3;
      case 4:
        return Icons.looks_4;
      case 5:
        return Icons.looks_5;
      case 6:
        return Icons.looks_6;
      default:
        return Icons.looks_one;
    }
  }
}
