import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_qr_check/models/attendant.dart';

class Event {
  final int id;
  final String name;
  final List<Attendant> attendants;
  final DocumentReference reference;

  Event(
    this.id, 
    this.name, 
    {this.attendants = const [], this.reference});

  Event.fromMap(Map<String, dynamic> map, this.reference)
     : assert(map['id'] != null),
       assert(map['name'] != null),
       id = map['id'],
       name = map['name'],
       attendants = map['attendants'] == null ? [] : (map['attendats'] as List)
                      .map((a) => Attendant.fromSnapshot(a));

  Event.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, snapshot.reference);
}