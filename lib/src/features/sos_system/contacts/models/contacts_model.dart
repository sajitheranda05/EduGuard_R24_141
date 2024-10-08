import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsModel {
  final String id;
  final String email;
  final String name;
  final String number;
  final String priority;

  ContactsModel({
    required this.id,
    required this.email,
    required this.name,
    required this.number,
    required this.priority,
  });

  //empty contacts model
  static ContactsModel empty() => ContactsModel(
    id: '',
    email: '',
    name: '',
    number: '',
    priority: '',
  );

  //Convert model to JSON structure
  Map<String, dynamic> toJSON() {
    return {
      'id' : '',
      'email' : email,
      'name': name,
      'number': number,
      'priority': priority,
    };
  }

  factory ContactsModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    if (document.data() != null) {
      final data =document.data()!;
      return ContactsModel(
        id: document.id,
        email: data['email'] ?? '',
        name: data['name'] ?? '',
        number: data['number'] ?? '',
        priority: data['priority'] ?? '',
      );
    } else {
      return ContactsModel.empty();
    }
  }
}