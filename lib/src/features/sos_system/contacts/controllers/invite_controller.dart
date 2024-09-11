import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/personalization/controllers/user_controller.dart';
import 'package:eduguard/src/features/sos_system/chat/controllers/chat_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/invite_model.dart';
import 'package:get/get.dart';

class InviteController extends GetxController {
  static InviteController get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // To store pending invites and sent invites
  var pendingInvites = <InviteModel>[].obs;
  var sentInvites = <InviteModel>[].obs;

  var user =AuthenticationRepository.instance.authUser;
  final userController =Get.put(UserController());

  // Fetch pending invites (received) for the authenticated user
  void fetchInvites(String userId) async {
    // Fetch received invites
    final pendingSnapshot = await _firestore
        .collection('EmergencyContacts')
        .doc(userId)
        .collection('Invites')
        .where('inviteStatus', isEqualTo: 'pending')
        .get();

    pendingInvites.value = pendingSnapshot.docs
        .map((doc) => InviteModel.fromSnapshot(doc))
        .toList();

    // Fetch sent invites
    final sentSnapshot = await _firestore
        .collection('EmergencyContacts')
        .doc(userId)
        .collection('SentInvites')
        .get();

    sentInvites.value = sentSnapshot.docs
        .map((doc) => InviteModel.fromSnapshot(doc))
        .toList();
  }

// Send an invite
  Future<void> sendInvite(String authenticatedUserId,InviteModel invite) async {
    // Add to authenticated user's SentInvites
    await _firestore
        .collection('EmergencyContacts')
        .doc(authenticatedUserId)
        .collection('SentInvites')
        .doc(invite.id)
        .set(invite.toJSON());

    // Add to recipient's Invites
    await _firestore
        .collection('EmergencyContacts')
        .doc(invite.id) // The recipient's ID
        .collection('Invites')
        .doc(userController.user.value.id)
        .set({
      'id' : userController.user.value.id,
      'email' : userController.user.value.email,
      'name' : userController.user.value.fullName,
      'number' : userController.user.value.contactNumber,
      'inviteStatus' : 'pending',
    });
  }

  //Accept invite
  Future<void> acceptInvite(String userId, InviteModel invite) async {
    try {
      handleInvites(invite);
      addSenderAsEmergencyContact(userId, invite);
      addRecipientAsEmergencyContact(invite.id, invite);

      // Fetch the current user's contact details
      ContactsController.instance.fetchContactDetails();

      // After accepting the invite, create a chatroom between the user and the contact
      await ChatroomController.instance.createChatRoomForAcceptedInvite(userId, invite.id);

    } catch (e) {
      print(e);
    }
  }

  Future<void> addSenderAsEmergencyContact(String userId, InviteModel invite) async {
    try {
      await _firestore
          .collection('EmergencyContacts')
          .doc(userId)
          .collection('Contacts')
          .doc(invite.id) // Add sender's ID as the document ID
          .set({
        'id': invite.id,
        'email': invite.email,
        'name': invite.name,
        'number': invite.number,
        'priority': 'low',
        'inviteStatus': 'accepted',
      });
    } catch (e) {
      // Handle errors if any
      print('Failed to add sender as contact: $e');
    }
  }

  Future<void> addRecipientAsEmergencyContact(String senderId, InviteModel invite) async {
    try {
      await _firestore
          .collection('EmergencyContacts')
          .doc(senderId)
          .collection('Contacts')
          .doc(userController.user.value.id) // Add recipient's ID as the document ID
          .set({
        'id': userController.user.value.id,
        'email': userController.user.value.email,
        'name': userController.user.value.fullName,
        'number': userController.user.value.contactNumber,
        'priority' : 'low',
        'inviteStatus': 'accepted',
      });
    } catch (e) {
      // Handle errors if any
      print('Failed to add recipient as contact: $e');
    }
  }

  Future<void> handleInvites(InviteModel invite) async{
    final userId =userController.user.value.id;
    //update the status of accepted invite
    await _firestore
        .collection('EmergencyContacts')
        .doc(userId)
        .collection('Invites')
        .doc(invite.id)
        .update({'inviteStatus': 'accepted'});

    // Remove the invite from the Invites collection
      await _firestore
          .collection('EmergencyContacts')
          .doc(userId)
          .collection('Invites')
          .doc(invite.id)
          .delete();

    //update the status of sent invite
    await _firestore
        .collection('EmergencyContacts')
        .doc(invite.id)
        .collection('SentInvites')
        .doc(userId)
        .update({'inviteStatus': 'accepted'});

    // Remove the invite from the Invites collection
    await _firestore
        .collection('EmergencyContacts')
        .doc(invite.id)
        .collection('SentInvites')
        .doc(userId)
        .delete();
  }


  // Reject an invite
  Future<void> rejectInvite(String userId, InviteModel invite) async {
    final userId =userController.user.value.id;
    //update the status of rejected invite
    await _firestore
        .collection('EmergencyContacts')
        .doc(userId)
        .collection('Invites')
        .doc(invite.id)
        .update({'inviteStatus': 'rejected'});

    // Remove the invite from the Invites collection
      await _firestore
          .collection('EmergencyContacts')
          .doc(userId)
          .collection('Invites')
          .doc(invite.id)
          .delete();

    //update the status of sent invite
    await _firestore
        .collection('EmergencyContacts')
        .doc(invite.id)
        .collection('SentInvites')
        .doc(userId)
        .update({'inviteStatus': 'rejected'});

    // Remove the invite from the Invites collection
    await _firestore
        .collection('EmergencyContacts')
        .doc(invite.id)
        .collection('SentInvites')
        .doc(userId)
        .delete();
  }

  // Check if the email is already in SentInvites or Invites
  Future<bool> isEmailAlreadyInvited(String authenticatedUserId, String email) async {
    // Check in SentInvites
    final sentInviteSnapshot = await _firestore
        .collection('EmergencyContacts')
        .doc(authenticatedUserId)
        .collection('SentInvites')
        .where('email', isEqualTo: email)
        .get();

    // Check in Invites (Received)
    final receivedInviteSnapshot = await _firestore
        .collection('EmergencyContacts')
        .doc(authenticatedUserId)
        .collection('Invites')
        .where('email', isEqualTo: email)
        .get();

    return sentInviteSnapshot.docs.isNotEmpty || receivedInviteSnapshot.docs.isNotEmpty;
  }
}
