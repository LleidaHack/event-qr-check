import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference collection;

  UserService()
      : collection = Firestore.instance.collection('hackeps-2019/prod/users');

  DocumentReference getUserReference(String uid) => collection.document(uid);

  Future<DocumentSnapshot> getUserSnapshotFromQR(String barcode) =>
      getUserReference(barcode).get();
}
