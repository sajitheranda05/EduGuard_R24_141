import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/contacts_model.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/user_search_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ContactRepository extends GetxController {
  static ContactRepository get instance => Get.find();

  final FirebaseFirestore _db =FirebaseFirestore.instance;

  Future<void> saveContactsRecord({
    required String highPriorityContactEmail,
    required String contactOneEmail,
    required String contactTwoEmail,
    required String contactThreeEmail,

    required String highPriorityContactName,
    required String contactOneName,
    required String contactTwoName,
    required String contactThreeName,

    required String highPriorityContactNumber,
    required String contactOneNumber,
    required String contactTwoNumber,
    required String contactThreeNumber,
  }) async {
    try {

      final userDocRef = _db.collection('EmergencyContacts').doc(AuthenticationRepository.instance.authUser?.uid);

      // Prepare a list of contacts with their details
      List<Map<String, String>> contacts = [
        {
          'email': highPriorityContactEmail,
          'name': highPriorityContactName,
          'number': highPriorityContactNumber,
          'priority': 'high'
        },
        {
          'email': contactOneEmail,
          'name': contactOneName,
          'number': contactOneNumber,
          'priority': 'lowOne'
        },
        {
          'email': contactTwoEmail,
          'name': contactTwoName,
          'number': contactTwoNumber,
          'priority': 'lowTwo'
        },
        {
          'email': contactThreeEmail,
          'name': contactThreeName,
          'number': contactThreeNumber,
          'priority': 'lowThree'
        },
      ];

      // Fetch the existing contacts
      final existingContactsSnapshot = await userDocRef.collection('Contacts').get();

      // Delete existing contacts if they exist
      for (var doc in existingContactsSnapshot.docs) {
        await doc.reference.delete();
      }

      // Add the new contacts, ensuring only four are added
      for (var contact in contacts) {
        if (contact['email'] != null && contact['email']!.isNotEmpty) {
          await userDocRef.collection('Contacts').add({
            'email': contact['email'],
            'name': contact['name'],
            'number': contact['number'],
            'priority': contact['priority'],
            // Add any other fields you need
          });
        }
      }

    } on FirebaseException catch (e) {
      throw ('Firebase Exception : $e');
    } on FormatException catch (e) {
      throw ('Format Exception : $e');
    } on PlatformException catch (e) {
      throw ('Platform Exception : $e');
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  //search user details
  Future<QuerySnapshot<Map<String, dynamic>>> searchUsers(String query) async {
    return _db
        .collection('Users')
        .where('Email', isGreaterThanOrEqualTo: query)
        .where('Email', isLessThanOrEqualTo: query + '\uf8ff')
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


}
