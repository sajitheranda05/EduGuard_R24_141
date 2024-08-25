import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sos_edit_settings_controller.dart';

class SOSEditSettings extends StatelessWidget {
  const SOSEditSettings({super.key});

  @override
  Widget build(BuildContext context) {

    final contactSettingsController = Get.put(ContactSettingsController());

    return Scaffold(
      // AppBar
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),

      // Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Settings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            const Divider(),
            const SizedBox(height: 24.0),

            Form(
              key: contactSettingsController.contactSettingsFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => TextFormField(
                            controller: contactSettingsController
                                .highPriorityContactEmail.value,
                            validator: (value) =>
                                AppValidations.validateContactEmail(value),
                            decoration: InputDecoration(
                              labelText: 'High Priority Contact Email',
                              suffixIcon: contactSettingsController
                                      .highPriorityContactEmail
                                      .value
                                      .text
                                      .isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear_rounded,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        contactSettingsController.clearEmailField(
                                            contactSettingsController
                                                .highPriorityContactEmail);
                                      },
                                    )
                                  : null,
                            ),
                            onChanged: (value) {
                              contactSettingsController
                                  .searchUsersForHighPriorityContact(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (contactSettingsController
                        .searchResultsForHighPriorityContact.isEmpty) {
                      return const SizedBox.shrink(); // No results to display
                    }

                    return Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: contactSettingsController
                            .searchResultsForHighPriorityContact.length,
                        itemBuilder: (context, index) {
                          final user = contactSettingsController
                              .searchResultsForHighPriorityContact[index];
                          return ListTile(
                            title: Text(user.fullName),
                            subtitle: Text(user.email),
                            onTap: () {
                              contactSettingsController
                                  .assignHighPriorityContactEmailToTextField(
                                      user.email);
                              //userSearchController.clearSearchResults(); // Clear after selection
                            },
                          );
                        },
                      ),
                    );
                  }),
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
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => TextFormField(
                            controller: contactSettingsController.contactOneEmail.value,
                            validator: (value) => AppValidations.validateContactEmail(value),
                            decoration: InputDecoration(
                              labelText: 'Contact One Email',
                              suffixIcon: contactSettingsController
                                      .contactOneEmail.value.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear_rounded,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        contactSettingsController.clearEmailField(
                                            contactSettingsController
                                                .contactOneEmail);
                                      },
                                    )
                                  : null,
                            ),
                            onChanged: (value) {
                              contactSettingsController
                                  .searchUsersForContactOne(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (contactSettingsController
                        .searchResultsForContactOne.isEmpty) {
                      return const SizedBox.shrink(); // No results to display
                    }

                    return Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: contactSettingsController
                            .searchResultsForContactOne.length,
                        itemBuilder: (context, index) {
                          final user = contactSettingsController
                              .searchResultsForContactOne[index];
                          return ListTile(
                            title: Text(user.fullName),
                            subtitle: Text(user.email),
                            onTap: () {
                              contactSettingsController
                                  .assignContactOneEmailToTextField(user.email);
                              //userSearchController.clearSearchResults(); // Clear after selection
                            },
                          );
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => TextFormField(
                            controller: contactSettingsController.contactTwoEmail.value,
                            validator: (value) => AppValidations.validateContactEmail(value),
                            decoration: InputDecoration(
                              labelText: 'Contact Two Email',
                              suffixIcon: contactSettingsController
                                      .contactTwoEmail.value.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear_rounded,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        contactSettingsController.clearEmailField(
                                            contactSettingsController
                                                .contactTwoEmail);
                                      },
                                    )
                                  : null,
                            ),
                            onChanged: (value) {
                              contactSettingsController
                                  .searchUsersForContactTwo(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (contactSettingsController
                        .searchResultsForContactTwo.isEmpty) {
                      return const SizedBox.shrink(); // No results to display
                    }

                    return Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: contactSettingsController
                            .searchResultsForContactTwo.length,
                        itemBuilder: (context, index) {
                          final user = contactSettingsController
                              .searchResultsForContactTwo[index];
                          return ListTile(
                            title: Text(user.fullName),
                            subtitle: Text(user.email),
                            onTap: () {
                              contactSettingsController
                                  .assignContactTwoEmailToTextField(user.email);
                              //userSearchController.clearSearchResults(); // Clear after selection
                            },
                          );
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => TextFormField(
                            controller: contactSettingsController.contactThreeEmail.value,
                            validator: (value) => AppValidations.validateContactEmail(value),
                            decoration: InputDecoration(
                              labelText: 'Contact Three Email',
                              suffixIcon: contactSettingsController
                                      .contactThreeEmail.value.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear_rounded,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        contactSettingsController.clearEmailField(
                                            contactSettingsController
                                                .contactThreeEmail);
                                      },
                                    )
                                  : null,
                            ),
                            onChanged: (value) {
                              contactSettingsController
                                  .searchUsersForContactThree(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (contactSettingsController
                        .searchResultsForContactThree.isEmpty) {
                      return const SizedBox.shrink(); // No results to display
                    }

                    return Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: contactSettingsController
                            .searchResultsForContactThree.length,
                        itemBuilder: (context, index) {
                          final user = contactSettingsController
                              .searchResultsForContactThree[index];
                          return ListTile(
                            title: Text(user.fullName),
                            subtitle: Text(user.email),
                            onTap: () {
                              contactSettingsController
                                  .assignContactThreeEmailToTextField(
                                      user.email);
                              //userSearchController.clearSearchResults(); // Clear after selection
                            },
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            const Divider(),
            const SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  contactSettingsController.saveContactSettings();
                },
                child: const Text('Save Settings'),
              ),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
