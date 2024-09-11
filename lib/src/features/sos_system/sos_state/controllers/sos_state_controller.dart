import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/sos_system/chat/controllers/chat_controller.dart';
import 'package:eduguard/src/features/sos_system/chat/screens/chat_screen.dart';
import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/contacts_model.dart';
import 'package:eduguard/src/features/sos_system/location/controllers/map_controller.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';

class SOSStateController extends GetxController {

  final mapController =Get.put(MapController());

  RxInt secondsRemaining =10.obs;
  RxBool isCanceled =false.obs;
  Timer? countdownTimer;

  RxInt callCountdownSecondsRemaining =10.obs;
  Timer? callCountdownTimer;

  final highPriorityContact = ContactsController.instance.fetchedContacts.firstWhere(
        (contact) => contact.priority == 'high',
    orElse: () => ContactsModel.empty(),
  );

  @override
  void onInit() async {
    super.onInit();
    startCountdown();
    startCountdownforCall();
  }

  @override
  void onClose() {
    countdownTimer?.cancel();
    super.onClose();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
        await sendSosNotificationToContacts();
      }
    });
  }

  void startCountdownforCall(){
    callCountdownTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (callCountdownSecondsRemaining.value > 0) {
        callCountdownSecondsRemaining.value--;
      } else {
        // Call the high priority contact here
        callCountdownTimer?.cancel();
        log(highPriorityContact.number);
        await FlutterPhoneDirectCaller.callNumber(highPriorityContact.number);
        // Add the call action here
      }
    });
  }

  void cancelCountdown() {
    callCountdownTimer?.cancel();
    isCanceled.value =true;
    callCountdownSecondsRemaining.value = 0;
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

  void handleSOSChat(String selectedContactId, String selectedContactName) {
    cancelCountdown();
    Get.to(() => ChatroomScreen(
      contactId: selectedContactId,
      contactName: selectedContactName,
      userId: AuthenticationRepository.instance.authUser!.uid,
    ));
  }

  void handleSOSLocation() {
    mapController.storeUserLocation();
  }



}