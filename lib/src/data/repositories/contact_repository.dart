import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/contacts_model.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/user_search_model.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ContactRepository extends GetxController {
  static ContactRepository get instance => Get.find();

  final FirebaseFirestore _db =FirebaseFirestore.instance;

  // Future<void> saveContactsRecord({
  //   required String highPriorityContactEmail,
  //   required String contactOneEmail,
  //   required String contactTwoEmail,
  //   required String contactThreeEmail,
  //
  //   required String highPriorityContactName,
  //   required String contactOneName,
  //   required String contactTwoName,
  //   required String contactThreeName,
  //
  //   required String highPriorityContactNumber,
  //   required String contactOneNumber,
  //   required String contactTwoNumber,
  //   required String contactThreeNumber,
  // }) async {
  //   try {
  //
  //     final userDocRef = _db.collection('EmergencyContacts').doc(AuthenticationRepository.instance.authUser?.uid);
  //
  //     // Prepare a list of contacts with their details
  //     List<Map<String, String>> contacts = [
  //       {
  //         'email': highPriorityContactEmail,
  //         'name': highPriorityContactName,
  //         'number': highPriorityContactNumber,
  //         'priority': 'high'
  //       },
  //       {
  //         'email': contactOneEmail,
  //         'name': contactOneName,
  //         'number': contactOneNumber,
  //         'priority': 'lowOne'
  //       },
  //       {
  //         'email': contactTwoEmail,
  //         'name': contactTwoName,
  //         'number': contactTwoNumber,
  //         'priority': 'lowTwo'
  //       },
  //       {
  //         'email': contactThreeEmail,
  //         'name': contactThreeName,
  //         'number': contactThreeNumber,
  //         'priority': 'lowThree'
  //       },
  //     ];
  //
  //     // Fetch the existing contacts
  //     final existingContactsSnapshot = await userDocRef.collection('Contacts').get();
  //
  //     // Delete existing contacts if they exist
  //     for (var doc in existingContactsSnapshot.docs) {
  //       await doc.reference.delete();
  //     }
  //
  //     // Fetch existing chatrooms related to these contacts
  //     final existingChatrooms = <String>[];
  //     for (var doc in existingContactsSnapshot.docs) {
  //       final contactEmail = doc.data()['email'] as String;
  //       final contactId = doc.id;
  //
  //       final chatroomsSnapshot = await FirebaseFirestore.instance
  //           .collection('Chatrooms')
  //           .where('members', arrayContains: contactId)
  //           .get();
  //
  //       for (var chatroomDoc in chatroomsSnapshot.docs) {
  //         final chatroomMembers = List<String>.from(chatroomDoc.data()['members']);
  //         if (chatroomMembers.contains(contactId) &&
  //             chatroomMembers.contains(FirebaseAuth.instance.currentUser?.uid ?? '')) {
  //           existingChatrooms.add(chatroomDoc.id);
  //         }
  //       }
  //     }
  //
  //     // Delete existing chatrooms
  //     for (var chatroomId in existingChatrooms) {
  //       await FirebaseFirestore.instance.collection('Chatrooms').doc(chatroomId).delete();
  //     }
  //
  //     // // Add the new contacts using their email as the document ID
  //     // for (var contact in contacts) {
  //     //   if (contact['email'] != null && contact['email']!.isNotEmpty) {
  //     //     final userSnapshot = await searchExactUserByEmail(contact['email']!);
  //     //
  //     //     if (userSnapshot.docs.isNotEmpty) {
  //     //       // Assuming the first match is the correct user
  //     //       final userId = userSnapshot.docs.first.id;
  //     //
  //     //       await userDocRef.collection('Contacts').doc(userId).set({
  //     //         'email': contact['email'],
  //     //         'name': contact['name'],
  //     //         'number': contact['number'],
  //     //         'priority': contact['priority'],
  //     //       });
  //     //     }
  //     //   }
  //     // }
  //
  //     // Create a new chatroom for each contact and update documents
  //     for (var contact in contacts) {
  //       if (contact['email'] != null && contact['email']!.isNotEmpty) {
  //         final userSnapshot = await searchExactUserByEmail(contact['email']!);
  //
  //         if (userSnapshot.docs.isNotEmpty) {
  //           final contactUserId = userSnapshot.docs.first.id;
  //           final userId = AuthenticationRepository.instance.authUser?.uid;
  //
  //           if (userId == null) {
  //             throw 'User ID is null';
  //           }
  //
  //           // Create chatroom and get chatroom ID
  //           final chatroomId = await _createChatroom(userId, contactUserId);
  //
  //           // Store contact information and chatroom ID for the authenticated user
  //           await userDocRef.collection('Contacts').doc(contactUserId).set({
  //             'email': contact['email'],
  //             'name': contact['name'],
  //             'number': contact['number'],
  //             'priority': contact['priority'],
  //             'chatroomId': chatroomId,
  //           }, SetOptions(merge: true)); // Use merge to avoid overwriting existing fields
  //
  //           // Store chatroom ID in the contact's document
  //           await FirebaseFirestore.instance
  //               .collection('EmergencyContacts')
  //               .doc(contactUserId)
  //               .collection('Contacts')
  //               .doc(userId)
  //               .set({
  //             'chatroomId': chatroomId,
  //           }, SetOptions(merge: true)); // Use merge to avoid overwriting existing fields
  //         } else {
  //           // Handle case where user is not found
  //           print('User with email ${contact['email']} not found');
  //         }
  //       }
  //     }
  //
  //   } on FirebaseException catch (e) {
  //     throw ('Firebase Exception : $e');
  //   } on FormatException catch (e) {
  //     throw ('Format Exception : $e');
  //   } on PlatformException catch (e) {
  //     throw ('Platform Exception : $e');
  //   } catch (e) {
  //     throw 'Something went wrong, Please try again';
  //   }
  // }

  // // Function to create a chatroom and return its ID
  // Future<String> _createChatroom(String userId, String contactId) async {
  //   try {
  //     // Create a new chatroom
  //     var newChatroom = await FirebaseFirestore.instance.collection('Chatrooms').add({
  //       'members': [userId, contactId],
  //       'createdAt': Timestamp.now(),
  //     });
  //
  //     // Return the new chatroom ID
  //     return newChatroom.id;
  //   } catch (e) {
  //     print('Error creating chatroom: $e');
  //     rethrow;
  //   }
  // }

  //search user details
  Future<QuerySnapshot<Map<String, dynamic>>> searchUsers(String query) async {
    return _db
        .collection('Users')
        .where('Email', isGreaterThanOrEqualTo: query)
        .where('Email', isLessThanOrEqualTo: query + '\uf8ff')
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> searchExactUserByEmail(String query) async {
    return _db
        .collection('Users')
        .where('Email', isEqualTo: query)
        .get();
  }

  Future<List<ContactsModel>> fetchContactsDetails() async {
    try {
      final contactDocs = await _db
          .collection('EmergencyContacts')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection('Contacts')
          .get();

      // Convert the fetched documents to a List of ContactsModel
      return contactDocs.docs
          .map((doc) => ContactsModel.fromSnapshot(doc))
          .toList();

    } on FirebaseException catch (e) {
      throw Exception('Firebase Exception: $e');
    } on FormatException catch (e) {
      throw Exception('Format Exception: $e');
    } on PlatformException catch (e) {
      throw Exception('Platform Exception: $e');
    } catch (e) {
      throw Exception('Something went wrong, Please try again');
    }
  }


  Future<UserSearchModel> getUserDetailsByEmail(String email) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> result = await _db
          .collection('Users')
          .where('Email', isEqualTo: email)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        return UserSearchModel.fromSnapshot(result.docs.first);
      } else {
        throw 'User not found';
      }
    } catch (e) {
      throw 'Error fetching user details: $e';
    }
  }

  Future<void> deleteEmergencyContact(String userId, String connectedUserId) async {
    try{

      //Remove the contact from users collection
      await _db
          .collection('EmergencyContacts')
          .doc(userId)
          .collection('Contacts')
          .doc(connectedUserId)
          .delete();

      //Remove the user from connected user's collection
      await _db
          .collection('EmergencyContacts')
          .doc(connectedUserId)
          .collection('Contacts')
          .doc(userId)
          .delete();

    } on FirebaseException catch (e) {
      throw Exception('Firebase Exception: $e');
    } on FormatException catch (e) {
      throw Exception('Format Exception: $e');
    } on PlatformException catch (e) {
      throw Exception('Platform Exception: $e');
    } catch (e) {
      throw Exception('Something went wrong, Please try again');
    }

  }


}
