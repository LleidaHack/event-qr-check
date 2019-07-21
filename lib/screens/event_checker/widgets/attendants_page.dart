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
    return Container(child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(40.0),
          child: Icon(
            Icons.person_outline, 
            size: 150.0, 
            color: Colors.grey,
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: EventService()
                    .eventAttendantsCollection(widget.event.id)
                    .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) 
              return SpinnerLoader();
            return Expanded(
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.redAccent,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.0,),
                  children: snapshot.data.documents.map(_buildAttendant).toList()
                ),
              ),
            );
          }
        )
      ],
    ));
      
  }

  Widget _buildAttendant(DocumentSnapshot snapshot) {
    final attendant = Attendant.fromSnapshot(snapshot);

    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(right: 10.0),),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 20),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Color.fromARGB(255, 206, 147, 216),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(attendant.name, style: TextStyle(fontSize: 30.0),),
            Text(attendant.email, style: TextStyle(color: Colors.grey),)
          ],
        )
      ],
    );
  }
}