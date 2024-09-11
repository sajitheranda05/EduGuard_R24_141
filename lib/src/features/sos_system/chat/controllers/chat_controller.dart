import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/features/sos_system/chat/models/contact_model.dart';
import 'package:eduguard/src/features/sos_system/chat/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import'package:http/http.dart' as http;

class ChatroomController extends GetxController {
  static ChatroomController get instance => Get.find();

  var contacts = <Contact>[].obs;
  var messages = <Message>[].obs;
  RxBool loading =true.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  void fetchContacts() async {
    try {
      loading.value =true;
      // Reference to the authenticated user's contacts collection
      final contactsCollectionRef = FirebaseFirestore.instance
          .collection('EmergencyContacts')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('Contacts');

      // Fetch all contacts
      final contactsSnapshot = await contactsCollectionRef.get();

      // Temporary list to hold the contacts
      List<Contact> tempContacts = [];

      // Iterate over each contact document
      for (var contactDoc in contactsSnapshot.docs) {
        final contactID = contactDoc.id;
        final contactData = contactDoc.data();

        // Fetch the last message from the Chat collection under this contact
        final lastMessageSnapshot = await contactsCollectionRef
            .doc(contactID)
            .collection('Chat')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

        String lastMessage = '';
        String lastMessageTime = '';
        int unreadCount = 0;

        if (lastMessageSnapshot.docs.isNotEmpty) {
          final messageData = lastMessageSnapshot.docs.first.data();
          lastMessage = messageData['message'] ?? '';
          lastMessageTime = (messageData['timestamp'] as Timestamp)
              .toDate()
              .toLocal()
              .toString(); // Format this as needed

          // Optionally count unread messages (if you track read/unread status)
          unreadCount = await contactsCollectionRef
              .doc(contactID)
              .collection('Chat')
              .where('isRead', isEqualTo: false)
              .get()
              .then((snapshot) => snapshot.docs.length);
        }

        // Create a Contact instance
        final contact = Contact(
          id: contactID,
          name: contactData['name'] ?? 'Unknown', // Assuming contact name is stored
          initials: contactData['name'] != null
              ? contactData['name'].substring(0, 1).toUpperCase()
              : 'U',
          lastMessage: lastMessage,
          lastMessageTime: lastMessageTime,
        );

        // Add contact to the list
        tempContacts.add(contact);
      }

      // Update the contacts list with fetched data
      contacts.value = tempContacts;
    } catch (e) {
      // Handle errors (e.g., network issues, permissions)
      print("Error fetching contacts: $e");
    }finally{
      loading.value =false;
    }
  }

  // Fetch messages for a specific chatroom in real-time
  void fetchMessages(String chatroomId) {
    FirebaseFirestore.instance
        .collection('Chatrooms')
        .doc(chatroomId)
        .collection('Messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
    });
  }

  Future<void> sendMessage(String chatroomId, String senderId, String recipientId, String messageText) async {
    // Create the message in Firestore
    await _firestore.collection('Chatrooms').doc(chatroomId).collection('Messages').add({
      'senderId': senderId,
      'message': messageText,
      'timestamp': Timestamp.now(),
    });

    try {
      // Retrieve the recipient's FCM token from Firestore
      DocumentSnapshot recipientSnapshot = await _firestore.collection('Users').doc(recipientId).get();

      if (recipientSnapshot.exists) {
        String? recipientToken = recipientSnapshot['fcmToken'];

        if (recipientToken != null) {
          // Send the notification using your Flask API
          await sendFCMNotification(recipientToken, messageText);
        } else {
          print('Recipient token not found');
        }
      } else {
        print('Recipient document not found');
      }
    } catch (e) {
      print('Error retrieving recipient FCM token: $e');
    }
  }

  //Create a api for this
  Future<void> sendFCMNotification(String token, String messageText) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/send_notification'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'token': token,
        'message': messageText,
      }),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification: ${response.statusCode}');
    }
  }

  Future<String?> getChatroomId(String userId, String contactId) async {
    try {
      // Retrieve chatroom ID from the user's document
      var chatroomDoc = await FirebaseFirestore.instance.collection('EmergencyContacts')
          .doc(userId)
          .collection('Contacts')
          .doc(contactId)
          .get();

      return chatroomDoc.data()?['chatroomId'] as String?;
    } catch (e) {
      // Handle errors (e.g., network issues)
      print("Error retrieving chatroom ID: $e");
      return null;
    }
  }


  Future<void> createChatRoomForAcceptedInvite(String userId, String contactId) async {
    try {
      // Check if a chatroom already exists between the two users
      final chatroomsSnapshot = await FirebaseFirestore.instance
          .collection('Chatrooms')
          .where('members', arrayContains: userId)
          .get();

      bool chatroomExists = false;
      String existingChatroomId = '';

      for (var chatroomDoc in chatroomsSnapshot.docs) {
        final chatroomMembers = List<String>.from(chatroomDoc.data()['members']);
        if (chatroomMembers.contains(contactId) && chatroomMembers.contains(userId)) {
          chatroomExists = true;
          existingChatroomId = chatroomDoc.id;
          break;
        }
      }

      if (!chatroomExists) {
        // Create a new chatroom if it doesn't already exist
        final chatroomId = await _createChatroom(userId, contactId);

        // Store chatroom ID for both users in Firestore
        await FirebaseFirestore.instance
            .collection('EmergencyContacts')
            .doc(userId)
            .collection('Contacts')
            .doc(contactId)
            .update({
          'chatroomId': chatroomId,
        });

        await FirebaseFirestore.instance
            .collection('EmergencyContacts')
            .doc(contactId)
            .collection('Contacts')
            .doc(userId)
            .update({
          'chatroomId': chatroomId,
        });
      } else {
        print('Chatroom already exists: $existingChatroomId');
      }
    } catch (e) {
      print('Error creating chatroom after invite acceptance: $e');
      rethrow;
    }
  }

  // Function to create a chatroom and return its ID
  Future<String> _createChatroom(String userId, String contactId) async {
    try {
      // Create a new chatroom
      var newChatroom = await FirebaseFirestore.instance.collection('Chatrooms').add({
        'members': [userId, contactId],
        'createdAt': Timestamp.now(),
      });

      // Return the new chatroom ID
      return newChatroom.id;
    } catch (e) {
      print('Error creating chatroom: $e');
      rethrow;
    }
  }

  Future<void> deleteChatroom(String userId, String contactId) async {
    final chatroomId =await getChatroomId(userId, contactId);
    //Remove the contact from users collection
    await FirebaseFirestore.instance
        .collection('Chatrooms')
        .doc(chatroomId)
        .delete();
  }


}
