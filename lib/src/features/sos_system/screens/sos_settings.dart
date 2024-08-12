import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/contacts_model.dart';
import 'package:eduguard/src/features/sos_system/contacts/screens/sos_edit_contacts.dart';
import 'package:eduguard/src/features/sos_system/screens/sos_edit_settings.dart';
import 'package:eduguard/src/features/sos_system/sos_common_widgets/sos_title_card.dart';
import 'package:eduguard/src/features/sos_system/sos_common_widgets/sos_display_contact.dart'; // Ensure this path is correct
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SOSSettings extends StatelessWidget {
  const SOSSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final contactsController =Get.put(ContactsController()); // Use Get.find() instead of Get.put() if it's already initialized

    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          children: [
            Obx(() {
              // Ensure that fetchedContacts is populated
              final highPriorityContact = contactsController.fetchedContacts.firstWhere(
                    (contact) => contact.priority == 'high',
                orElse: () => ContactsModel.empty(),
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSOSTitleCard(
                    title: 'Settings',
                    subtitle: 'This is the section for the contact settings.',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'High Priority Contact',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      IconButton(
                        onPressed: () => Get.to(() => const SOSEditSettings()),
                        icon: const Icon(Icons.keyboard_arrow_right_rounded),
                      ),
                    ],
                  ),
                  Text(
                    'This contact will be given the highest priority when using emergency functions.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                  ),
                  const SizedBox(height: 24.0),
                  CustomSOSContactDisplay(
                    contactName: highPriorityContact.name,
                    contactNumber: highPriorityContact.number,
                    email: highPriorityContact.email,
                  ),
                  const Divider(),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Emergency Contacts',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      IconButton(
                        onPressed: () => Get.to(() => ContactSettingsScreen()),
                        icon: const Icon(Icons.keyboard_arrow_right_rounded),
                      ),
                    ],
                  ),
                  Text(
                    'Manage your emergency contacts settings.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                  ),
                  const SizedBox(height: 24.0),
                  // Display additional contacts if available
                  ...contactsController.fetchedContacts.where((contact) => contact.priority != 'high').map(
                        (contact) => CustomSOSContactDisplay(
                      contactName: contact.name,
                      contactNumber: contact.number,
                      email: contact.email,
                    ),
                  ),
                  const Divider(),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}