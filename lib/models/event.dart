import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final int id;
  final String name;
  final int times;
  final DocumentReference reference;

  Event(
    this.id, 
    this.name, 
    this.times,
    {this.reference});

  Event.fromMap(Map<String, dynamic> map, this.reference)
     : assert(map['id'] != null),
       assert(map['name'] != null),
       id = map['id'],
       name = map['name'],
       times = map['times'];

  Event.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, snapshot.reference);
}