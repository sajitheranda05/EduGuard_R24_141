import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id;
  String senderId;
  String text;
  final bool readStatus;
  DateTime timestamp;

  Message({required this.id, required this.senderId, required this.text, required this.readStatus, required this.timestamp});

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      text: data['message'] ?? '',
      readStatus: data['readStatus'] ?? false,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}