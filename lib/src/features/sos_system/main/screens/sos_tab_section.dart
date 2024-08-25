import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/features/sos_system/main/screens/sos_state.dart';
import 'package:eduguard/src/features/sos_system/sos_common_widgets/sos_user_section.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SOSTabScreen extends StatelessWidget {
  const SOSTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contactsController = Get.put(ContactsController());

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                height: 350,
                alignment: Alignment.center,
                // Central SOS button
                child: ElevatedButton(
                  onPressed: () {
                    // Add your SOS button functionality here
                    Get.to(() => const SOSStateScreen());
                    print('SOS Button Pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(96.0),
                  ),
                  child: const Icon(
                    Icons.sos_outlined,
                    size: 64.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Obx(() {
               return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...contactsController.fetchedContacts.map(
                        (contact) => CustomSOSUSerImageSection(
                            contactName: contactsController.getFirstName(contact.name),
                            image: AppImages.userImage)
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
