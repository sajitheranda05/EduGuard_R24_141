import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/user_search_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildContactField extends StatelessWidget {
  const BuildContactField({
    super.key,
    required this.contactsController,
    required this.label,
    required this.emailController,
    required this.nameController,
    required this.numberController,
    required this.searchResults,
    required this.onSearch,
    required this.onAssign,
  });

  final ContactsController contactsController;
  final String label;
  final Rx<TextEditingController> emailController;
  final Rx<TextEditingController> nameController;
  final Rx<TextEditingController> numberController;
  final RxList<UserSearchModel> searchResults;
  final Function(String p1) onSearch;
  final Function(String p1) onAssign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => TextFormField(
            controller: emailController.value,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter an email' : null,
            decoration: InputDecoration(
              labelText: label,
              suffixIcon: emailController.value.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () =>
                          contactsController.clearEmailField(emailController),
                    )
                  : null,
            ),
            onChanged: (value) => onSearch(value),
          ),
        ),
        const SizedBox(height: 16.0),
        Obx(
          () => TextFormField(
            controller: nameController.value,
            readOnly: true,
            // Make this field read-only since it's auto-populated
            decoration: InputDecoration(
              labelText: '$label Name',
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Obx(
          () => TextFormField(
            controller: numberController.value,
            readOnly: true,
            // Make this field read-only since it's auto-populated
            decoration: InputDecoration(
              labelText: '$label Contact Number',
            ),
          ),
        ),
        Obx(() {
          if (searchResults.isEmpty) {
            return const SizedBox.shrink(); // No results to display
          }

          return Container(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final user = searchResults[index];
                return ListTile(
                  title: Text(user.fullName),
                  subtitle: Text(user.email),
                  onTap: () => onAssign(user.email),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
