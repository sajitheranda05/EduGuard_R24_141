import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/features/sos_system/sos_common_widgets/sos_build_contact.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactSettingsScreen extends StatelessWidget {
  final ContactsController contactsController = Get.put(ContactsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: contactsController.contactSettingsFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'Contact Settings',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                const Divider(),
                const SizedBox(height: 24.0),

                const Text(
                  'High Priority Contact',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                const SizedBox(height: 2.0),
                Text(
                  'This contact will be given the highest priority when using emergency functions.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                ),
                const SizedBox(height: 24.0),

                // High Priority Contact Email
                BuildContactField(
                    contactsController: contactsController,
                    label: 'High Priority Contact',
                    emailController: contactsController.highPriorityContactEmail,
                    nameController: contactsController.highPriorityContactName,
                    numberController: contactsController.highPriorityContactNumber,
                    searchResults: contactsController.searchResultsForHighPriorityContact,
                    onSearch: contactsController.searchUsersForHighPriorityContact,
                    onAssign: contactsController.assignHighPriorityContactEmailToTextField
                ),

                const SizedBox(height: 24.0),
                const Divider(),
                const SizedBox(height: 24.0),
                const Text(
                  'Emergency Contacts',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                const SizedBox(height: 2.0),
                Text(
                  'This is the section for the contact settings',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                ),
                const SizedBox(height: 24.0),

                // Contact One Email
                BuildContactField(
                    contactsController: contactsController,
                    label: 'Contact One',
                    emailController: contactsController.contactOneEmail,
                    nameController: contactsController.contactOneName,
                    numberController: contactsController.contactOneNumber,
                    searchResults: contactsController.searchResultsForContactOne,
                    onSearch: contactsController.searchUsersForContactOne,
                    onAssign: contactsController.assignContactOneEmailToTextField),
                const SizedBox(height: 48),

                // Contact Two Email
                BuildContactField(
                    contactsController: contactsController,
                    label: 'Contact Two',
                    emailController: contactsController.contactTwoEmail,
                    nameController: contactsController.contactTwoName,
                    numberController: contactsController.contactTwoNumber,
                    searchResults: contactsController.searchResultsForContactTwo,
                    onSearch: contactsController.searchUsersForContactTwo,
                    onAssign: contactsController.assignContactTwoEmailToTextField),
                const SizedBox(height: 48),

                // Contact Three Email
                BuildContactField(
                    contactsController: contactsController,
                    label: 'Contact Three',
                    emailController: contactsController.contactThreeEmail,
                    nameController: contactsController.contactThreeName,
                    numberController: contactsController.contactThreeNumber,
                    searchResults: contactsController.searchResultsForContactThree,
                    onSearch: contactsController.searchUsersForContactThree,
                    onAssign: contactsController.assignContactThreeEmailToTextField
                ),

                const SizedBox(height: 24.0),
                const Divider(),
                const SizedBox(height: 24.0),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: contactsController.saveContactSettings,
                    child: const Text('Save Settings'),
                  ),
                ),
                const SizedBox(height: 24.0),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
