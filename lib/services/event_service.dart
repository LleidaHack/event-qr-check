import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_qr_check/models/attendant.dart';
import 'package:event_qr_check/models/event.dart';

class EventService {
  final CollectionReference collection;

  EventService(): 
    collection = Firestore.instance.collection('events');

  Future<bool> alreadyAssisted(Event event, Attendant attendant) async {
    final collection = Firestore.instance.collection('/events/${event.id}/attendants');
    final docs = await collection
                  .where('email', isEqualTo: attendant.email)
                  .getDocuments();
    return docs.documents.length > 0;
  }

  Future<void> registerAttendant(Event event, Attendant attendant) async {
    await Firestore.instance.collection('/events/${event.id}/attendants')
      .document(attendant.email).setData(attendant.json());
  }

  Stream<QuerySnapshot> snapshots() {
    return this.collection.snapshots();
  }
}