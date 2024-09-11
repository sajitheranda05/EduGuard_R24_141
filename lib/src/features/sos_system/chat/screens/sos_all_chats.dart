import 'package:eduguard/src/features/sos_system/chat/controllers/chat_controller.dart';
import 'package:eduguard/src/features/sos_system/chat/screens/chat_screen.dart';
import 'package:eduguard/src/features/sos_system/contacts/screens/sos_edit_contacts.dart';
import 'package:eduguard/src/features/sos_system/contacts/screens/sos_settings.dart';
import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SOSAllChatsScreen extends StatefulWidget {
  const SOSAllChatsScreen({super.key});

  @override
  State<SOSAllChatsScreen> createState() => _SOSAllChatsScreenState();
}

class _SOSAllChatsScreenState extends State<SOSAllChatsScreen> {
  final ChatroomController chatController = Get.put(ChatroomController());

  @override
  void initState() {
    super.initState();
    chatController.fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {

        if (chatController.loading.value) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: AppColors.primary,
            ),
          );
        }

        if (chatController.contacts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No Emergency Contacts Found...',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() =>  const SOSSettings());
                  },
                  child: const Text('Add Emergency Contacts'),
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: chatController.contacts.length,
            itemBuilder: (context, index) {
              final contact = chatController.contacts[index];

              return ListTile(
                leading: CircleAvatar(
                  child: Text(contact.initials),
                ),
                title: Text(contact.name),
                subtitle: Text(contact.lastMessage),
                trailing: Text(
                  contact.lastMessageTime,
                  style: const TextStyle(fontSize: 12),
                ),
                onTap: () {
                  Get.to(() => ChatroomScreen(
                    contactId: contact.id,
                    contactName: contact.name,
                    userId: FirebaseAuth.instance.currentUser!.uid,
                  ));
                },
              );
            },
          );
        }
      }),
    );
  }
}
