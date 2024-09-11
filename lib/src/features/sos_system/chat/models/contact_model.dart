import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String id;
  final String name;
  final String initials;
  final String lastMessage;
  final String lastMessageTime;

  Contact({
    required this.id,
    required this.name,
    required this.initials,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  // Factory method to create a Contact instance from Firestore data
  factory Contact.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Assuming you store the full name and you want to generate initials from it
    String generateInitials(String fullName) {
      return fullName.isNotEmpty
          ? fullName.trim().split(' ').map((word) => word[0]).take(2).join().toUpperCase()
          : '';
    }

    return Contact(
      id: doc.id,
      name: data['name'] ?? '',
      initials: generateInitials(data['name'] ?? ''),
      lastMessage: data['lastMessage'] ?? 'No messages yet',
      lastMessageTime: (data['lastMessageTime'] as Timestamp?)?.toDate().toLocal().toString() ?? '',
    );
  }

  // Method to convert Contact instance back to a map for storing in Firestore (if needed)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
    };
  }
}
