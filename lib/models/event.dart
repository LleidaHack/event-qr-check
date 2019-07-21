import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_qr_check/models/attendant.dart';

class Event {
  final int id;
  final String name;
  final DocumentReference reference;

  Event(
    this.id, 
    this.name, 
    {this.reference});

  Event.fromMap(Map<String, dynamic> map, this.reference)
     : assert(map['id'] != null),
       assert(map['name'] != null),
       id = map['id'],
       name = map['name'];

  Event.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, snapshot.reference);
}