// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_qr_check/models/event.dart';
import 'package:event_qr_check/screens/home/widgets/event.dart';
import 'package:event_qr_check/services/event_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<Color> colors = [
    Color.fromARGB(255, 243, 229, 245),
    Color.fromARGB(255, 225, 190, 231),
    Color.fromARGB(255, 206, 147, 216)
  ];
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int eventIdx = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: EventService().snapshots(),
      builder: (context, snapshot) {
        eventIdx = -1;    

        if (!snapshot.hasData) return LinearProgressIndicator();

        return Column(
          children: snapshot.data.documents
                      .map(_buildEventButton).toList()
        );
      }
    );
  }

  EventButton _buildEventButton(DocumentSnapshot snapshot) {
    eventIdx++;    
    return EventButton(
      Event.fromSnapshot(snapshot), 
      widget.colors[eventIdx]
    );
  }
}