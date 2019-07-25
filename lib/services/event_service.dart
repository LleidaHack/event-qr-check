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
    final attendantRef = collection.document(attendant.email);
    final attendantSnapshot = await attendantRef.get();
    if (!attendantSnapshot.exists) {
      return false;
    }

    return attendantSnapshot.data['times'] == event.times;
  }

  Future<void> registerAttendant(Event event, Attendant attendant) async {
    final collection = eventAttendantsCollection(event.id);
    final attendantRef = collection.document(attendant.email);
    final attendantSnapshot = await attendantRef.get();
    if (attendantSnapshot.exists) {
      // Update time
      await attendantRef
            .updateData({'times': attendantSnapshot.data['times'] + 1});
    } else {
      // Insert attendant for the first time
      Map<String, dynamic> attendantMap = attendant.json();
      attendantMap['times'] = 1;
      await attendantRef.setData(attendantMap);
    }

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