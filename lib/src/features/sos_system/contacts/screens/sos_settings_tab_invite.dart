import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SOSSettingsTabInvite extends StatelessWidget {
  final ContactsController contactsController = Get.put(ContactsController());

  SOSSettingsTabInvite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
          child: Form(
            key: contactsController.contactSettingsFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24.0),

                TextField(
                  controller: contactsController.email,
                  decoration: const InputDecoration(
                    labelText: 'Search User',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (query) => contactsController.searchUsers(query),
                ),
                const SizedBox(height: 8.0),

                // Search Results
                Obx(() {
                  if (contactsController.searchResults.isEmpty) {
                    return const Center(child: Text('No users found.'));
                  }
                  return Container(
                    width: double.infinity,
                    height: 80,
                    child: ListView.builder(
                      itemCount: contactsController.searchResults.length,
                      itemBuilder: (context, index) {
                        final user = contactsController.searchResults[index];
                        return ListTile(
                          title: Text(user.fullName),
                          subtitle: Text(user.email),
                          trailing: IconButton(
                            icon: Icon(
                              contactsController.selectedUsers.contains(user)
                                  ? Icons.remove_circle
                                  : Icons.add_circle,
                              color: AppColors.primary,
                              size: 32,
                            ),
                            onPressed: () {
                              if (contactsController.selectedUsers.contains(user)) {
                                contactsController.removeUserFromList(user);
                              } else if (contactsController.selectedUsers.length < 4) { // limit to 4
                                contactsController.addUserToList(user);

                              }
                            },
                          ),
                          onTap: () => contactsController.assignEmailToTextField(user.email),
                        );
                      },
                    ),
                  );
                }),
                const SizedBox(height: 24.0),

                const Text(
                  'Selected Contacts',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                const SizedBox(height: 2.0),

                Text(
                  'This contact will be given the highest priority when using emergency functions.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                ),
                const SizedBox(height: 24.0),

                Obx(() {
                  if (contactsController.selectedUsers.isEmpty) {
                    return const Center(child: Text('No users selected.'));
                  }
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: contactsController.selectedUsers.length,
                      itemBuilder: (context, index) {
                        final user = contactsController.selectedUsers[index];
                        return ListTile(
                          title: Text(user.fullName),
                          subtitle: Text(user.email),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_circle,color: AppColors.primary, size: 32,),
                            onPressed: () {
                              contactsController.removeUserFromList(user);
                            },
                          ),
                        );
                      },
                    ),
                  );
                }),

                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 8)
                  ),
                  onPressed: () {
                    if (contactsController.selectedUsers.isEmpty) {
                      AppSnackBars.errorSnackBar(
                        title: 'No Users Selected...',
                        message: 'Please select at least one user to send a invitation',
                      );
                    } else {
                      contactsController.sendInvites();
                    }
                  },
                  child: const Text('Send Invites'),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
