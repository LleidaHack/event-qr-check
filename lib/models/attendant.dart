import 'package:cloud_firestore/cloud_firestore.dart';

class Attendant {
  final String fullName;
  final String email;
  final String nickname;
  final int times;
  final DocumentReference reference;

  Attendant(
      this.fullName, this.email, this.nickname, this.times, this.reference);

  String get documentID => reference.documentID;

  Attendant.fromMap(Map<String, dynamic> map, this.reference)
      : assert(map['nickname'] != null),
        assert(map['email'] != null),
        nickname = map['nickname'],
        fullName = map['fullName'],
        email = map['email'],
        times = map['times'] ?? 1;

  Attendant.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, snapshot.reference);

  Map<String, dynamic> json() {
    return {
      'fullName': fullName,
      'email': email,
      'nickname': nickname,
      'userRef': reference,
      'times': times,
      'lastTime': DateTime.now(),
    };
  }
}
