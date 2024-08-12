import 'package:cloud_firestore/cloud_firestore.dart';

class UserSearchModel {
  final String id;
  final String fullName;
  final String email;
  final String contactNumber;

  UserSearchModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.contactNumber,
  });

  factory UserSearchModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return UserSearchModel(
        id: document.id,
        fullName: '${data['FirstName'] ?? ''} ${data['LastName'] ?? ''}',
        email: data['Email'] ?? '',
        contactNumber: data['ContactNumber'] ?? '',
      );
    } else {
      throw Exception('Document does not contain data');
    }
  }

}