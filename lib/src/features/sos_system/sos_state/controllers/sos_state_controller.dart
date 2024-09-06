import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/sos_system/chat/controllers/chat_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class SOSStateController extends GetxController {

  @override
  void onInit() async {
    super.onInit();
    await sendSosNotificationToContacts();
  }

  Future<void> sendSosNotificationToContacts() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;

      // Loop through fetchedContacts to get emergency contact IDs
      for (var contact in ContactsController.instance.fetchedContacts) {
        String? contactId = contact.id;

        if (contactId != null) {
          // Retrieve the FCM token for each contact from Firestore
          DocumentSnapshot recipientSnapshot = await FirebaseFirestore.instance
              .collection('Users')
              .doc(contactId)
              .get();

          if (recipientSnapshot.exists && recipientSnapshot['fcmToken'] != null) {
            String fcmToken = recipientSnapshot['fcmToken'];

            // Send notification to the contact using their FCM token
            await sendSOSNotification(fcmToken, contact.name);
          } else {
            print('FCM token not found for contact: $contactId');
          }
        }
      }

      AppSnackBars.successSnackBar(title: 'Successfully notified other contacts');

    } catch (e) {
      print('Error sending SOS notifications: $e');
    }
  }

  Future<void> sendSOSNotification(String fcmToken, String contactName) async {
    final String message ='SOS Alert from ${contactName}';
    await ChatroomController.instance.sendFCMNotification(fcmToken, message);
  }



}