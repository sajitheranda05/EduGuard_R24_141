import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/contacts_model.dart';
import 'package:eduguard/src/features/sos_system/contacts/screens/sos_edit_contacts.dart';
import 'package:eduguard/src/features/sos_system/sos_common_widgets/sos_display_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SOSSettingsTabContacts extends StatelessWidget {
  const SOSSettingsTabContacts({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactsController contactsController =Get.put(ContactsController());

    return Scaffold(
      body: Obx(() {

        final highPriorityContact = contactsController.fetchedContacts.firstWhere(
              (contact) => contact.priority == 'high',
          orElse: () => ContactsModel.empty(),
        );
      
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'High Priority Contact',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                IconButton(
                  onPressed: () => Get.off(() => ContactSettingsScreen()),
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
                  onPressed: () => Get.off(() => ContactSettingsScreen()),
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
            ...contactsController.fetchedContacts.where((contact) => contact.priority == 'low').map(
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
    );
  }
}
