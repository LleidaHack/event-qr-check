import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_qr_check/models/attendant.dart';
import 'package:event_qr_check/models/event.dart';

class EventService {
  final CollectionReference collection;

  EventService(): 
    collection = Firestore.instance.collection('events');

  CollectionReference eventAttendantsCollection(int eventId) => 
     Firestore.instance.collection('events/$eventId/attendants');

  Future<bool> alreadyAssisted(Event event, Attendant attendant) async {
    final collection = eventAttendantsCollection(event.id);
    final docs = await collection
                  .where('email', isEqualTo: attendant.email)
                  .getDocuments();
    return docs.documents.length > 0;
  }

  Future<void> registerAttendant(Event event, Attendant attendant) async {
    final collection = eventAttendantsCollection(event.id);
    await collection
            .document(attendant.email)
            .setData(attendant.json());
  }

  Future<List<Attendant>> getAttendants(Event event) async {
    final collection = eventAttendantsCollection(event.id);
    final documents = (await collection.getDocuments()).documents;
    return documents.map((a) => Attendant.fromSnapshot((a)));
  }

  Stream<QuerySnapshot> snapshots() {
    return this.collection.snapshots();
  }
}