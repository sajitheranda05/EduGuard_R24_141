import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/features/sos_system/sos_common_widgets/sos_title_card.dart';
import 'package:eduguard/src/features/sos_system/sos_common_widgets/sos_user_section.dart';
import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sos_state_controller.dart';

class SOSStateScreen extends StatelessWidget {
  const SOSStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sosStateController = Get.put(SOSStateController());
    final contactsController = Get.put(ContactsController());

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 48,
            ),
            const CustomSOSTitleCard(
                title: 'Emergency SOS Activated...',
                subtitle:
                    'The emergency state will be recording audio to analyse distress instances.'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.multitrack_audio_sharp,
                  size: 48,
                ),
                SizedBox(width: 12,),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'App is recording...',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Recorded audio will be analyzed to identify distress instances.',
                        style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    //sosStateController.cancelRecording(); // Example method
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color:Colors.red),
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
            const SizedBox(height: 24.0,),
            Divider(),
            const SizedBox(height: 24.0,),
            
            const Text('Emergency Contacts',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
            const Text('All the emergency functions will be defaulted to high priority contact.',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12.0,),

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
            const SizedBox(height: 24.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary, // Background color
                    borderRadius: BorderRadius.circular(100), // Rounded corners if needed
                    border: Border.all(color: Colors.green[800]!), // Border
                  ),
                  padding: EdgeInsets.all(8), // Adjust padding as needed
                  child: IconButton(
                    onPressed: () {
                      // Action for the call button
                    },
                    icon: Icon(
                      Icons.call,
                      size: 32,
                      color: Colors.green[800], // Icon color
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary, // Background color
                    borderRadius: BorderRadius.circular(100), // Rounded corners if needed
                    border: Border.all(color: Colors.green[800]!), // Border
                  ),
                  padding: EdgeInsets.all(8), // Adjust padding as needed
                  child: IconButton(
                    onPressed: () {
                      // Action for the call button
                    },
                    icon: Icon(
                      Icons.chat,
                      size: 32,
                      color: Colors.green[800], // Icon color
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary, // Background color
                    borderRadius: BorderRadius.circular(100), // Rounded corners if needed
                    border: Border.all(color: Colors.green[800]!), // Border
                  ),
                  padding: EdgeInsets.all(8), // Adjust padding as needed
                  child: IconButton(
                    onPressed: () {
                      // Action for the call button
                    },
                    icon: Icon(
                      Icons.location_on,
                      size: 32,
                      color: Colors.green[800], // Icon color
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 24.0,),
            Divider(),
            const SizedBox(height: 24.0,),
            ElevatedButton(
                onPressed: () {
                  sosStateController.toggleSOS();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  minimumSize: Size(double.infinity, 0),
                  side: const BorderSide(color: Colors.red),
                ),
                child: Text('Deactivate SOS')
            ),
            const SizedBox(height: 24.0,),
          ],
        ),
      ),
    );
  }
}
