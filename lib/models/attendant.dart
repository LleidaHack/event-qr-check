import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Attendant {
  final String name;
  final String email;
  final DocumentReference reference;

  Attendant(this.name, this.email, {this.reference});

  factory Attendant.fromQR(String qrContent) {
    // final attendant = json.decode(qrContent);
    final attendant = {
      'name': 'Guillem',
      'email': 'guillem@mail.com'
    };

    return Attendant(attendant['name'], attendant['email']);
  }

  Attendant.fromMap(Map<String, dynamic> map, this.reference)
     : assert(map['name'] != null),
       assert(map['email'] != null),
       name = map['name'],
       email = map['email'];

  Attendant.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, snapshot.reference);

  Map<String, String> json() {
    return {
      'name': name,
      'email': email
    };
  }
}