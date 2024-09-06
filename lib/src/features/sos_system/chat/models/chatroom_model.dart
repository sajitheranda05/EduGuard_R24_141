import 'package:cloud_firestore/cloud_firestore.dart';

class Chatroom {
  String id;
  List<String> members;

  Chatroom({required this.id, required this.members});

  factory Chatroom.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Chatroom(
      id: doc.id,
      members: List<String>.from(data['members'] ?? []),
    );
  }
}