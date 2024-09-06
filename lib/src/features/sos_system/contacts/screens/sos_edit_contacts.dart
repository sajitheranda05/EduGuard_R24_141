import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/contacts_model.dart';
import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/sos_system/sos_common_widgets/sos_display_contact.dart';
import 'package:eduguard/src/features/sos_system/sos_common_widgets/sos_title_card.dart';

class ContactSettingsScreen extends StatefulWidget {
  @override
  State<ContactSettingsScreen> createState() => _ContactSettingsScreenState();
}

class _ContactSettingsScreenState extends State<ContactSettingsScreen> {
  final ContactsController contactsController = Get.put(ContactsController());
  String? selectedContactEmail;

  @override
  void initState() {
    super.initState();

    // Initialize selectedContactEmail with the current high-priority contact if available
    final highPriorityContact = contactsController.fetchedContacts.firstWhere(
          (contact) => contact.priority == 'high',
      orElse: () => ContactsModel.empty(),
    );

    // Set the initial selected value only if the contact is valid (not empty)
    if (highPriorityContact.email.isNotEmpty) {
      selectedContactEmail = highPriorityContact.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Obx(() {
          // Ensure there are no duplicate emails in the list
          final uniqueContacts = contactsController.fetchedContacts.toSet();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSOSTitleCard(
                title: 'Edit Emergency Contacts',
                subtitle: 'This is the section for the contact settings.',
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'High Priority Contact',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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

              // Dropdown for High Priority Contact
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedContactEmail,
                      hint: const Text('High priority contact'),
                      items: uniqueContacts.map((contact) {
                        return DropdownMenuItem<String>(
                          value: contact.email,
                          child: Text(contact.email),
                        );
                      }).toList(),
                      dropdownColor: Colors.white,
                      onChanged: (String? selectedContact) {
                        setState(() {
                          selectedContactEmail = selectedContact;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Contact',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) =>
                      value == null ? 'Please select a contact' : null,
                    ),
                  ),
                  const SizedBox(width: 4),
                  OutlinedButton(
                    onPressed: () {
                      if (selectedContactEmail != null) {
                        contactsController.setHighPriorityContact(selectedContactEmail!);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),

              const SizedBox(height: 24.0),
              const Divider(),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Emergency Contacts',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
              ...contactsController.fetchedContacts.map(
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
      ),
    );
  }
}
