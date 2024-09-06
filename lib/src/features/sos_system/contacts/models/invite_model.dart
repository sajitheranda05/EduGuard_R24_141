import 'package:cloud_firestore/cloud_firestore.dart';

class InviteModel {
  final String id;
  final String email;
  final String name;
  final String number;
  final String inviteStatus;

  InviteModel({
    required this.id,
    required this.email,
    required this.name,
    required this.number,
    required this.inviteStatus,
  });

  // Convert InviteModel to JSON for Firestore
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'number': number,
      'inviteStatus': inviteStatus,
    };
  }

  // Create an InviteModel from Firestore snapshot
  factory InviteModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return InviteModel(
      id: snapshot.id,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      number: data['number'] ?? '',
      inviteStatus: data['inviteStatus'] ?? '',
    );
  }

  // Create a copy with modified fields
  InviteModel copyWith({
    String? id,
    String? email,
    String? name,
    String? number,
    String? inviteStatus,
  }) {
    return InviteModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      number: number ?? this.number,
      inviteStatus: inviteStatus ?? this.inviteStatus,
    );
  }
}
