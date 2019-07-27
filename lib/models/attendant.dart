import 'dart:convert' as convert;
import 'package:cloud_firestore/cloud_firestore.dart';

class Attendant {
  final String name;
  final String email;
  final int times;
  final DocumentReference reference;

  Attendant(this.name, this.email, this.times, {this.reference});

  factory Attendant.fromQR(String qrContent) {
    final attendant = convert.json.decode(qrContent.replaceAll("&#34;", '"'));
    // final attendant = {
    //   'name': 'Guillem',
    //   'email': 'guillem@mail.com'
    // };

    return Attendant(attendant['name'], attendant['email'], 1);
  }

  Attendant.fromMap(Map<String, dynamic> map, this.reference)
     : assert(map['name'] != null),
       assert(map['email'] != null),
       name = map['name'],
       email = map['email'],
       times = map.containsKey('times') ? map['times'] : 1;

  Attendant.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, snapshot.reference);

  Map<String, dynamic> json() {
    return {
      'name': name,
      'email': email,
      'times': times
    };
  }
}