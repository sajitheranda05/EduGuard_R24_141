import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/features/sos_system/sos_common_widgets/sos_title_card.dart';
import 'package:eduguard/src/features/sos_system/sos_common_widgets/sos_user_section.dart';
import 'package:eduguard/src/features/sos_system/sos_state/test/test_state.dart';
import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import '../controllers/sos_state_controller.dart';

class SOSStateScreen extends StatelessWidget {
  const SOSStateScreen({super.key});




  @override
  Widget build(BuildContext context) {
    final sosStateController = Get.put(SOSStateController());
    //final contactsController = Get.put(ContactsController());
    final contactsController =Get.find<ContactsController>();



    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24.0,
            ),
            const CustomSOSTitleCard(
                title: 'Emergency SOS Activated...',
                subtitle: 'The emergency state will be recording audio to analyse distress instances.',
            ),

            AudioState(),

            Divider(),
            const SizedBox(height: 8.0,),

            const Text('Emergency Contacts',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
            // const Text('All the emergency functions will be defaulted to high priority contact.',
            //   style: TextStyle(
            //       fontSize: 12,
            //       fontWeight: FontWeight.w400
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            const SizedBox(height: 12.0,),

            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    contactsController.fetchedContacts.length,
                        (index) {
                      var contact = contactsController.fetchedContacts[index];
                      bool isSelected = contactsController.selectedContactIndex.value == index;

                      return GestureDetector(
                        onTap: () {
                          contactsController.selectContact(index);
                        },
                        child: CustomSOSUSerImageSection(
                          contactName: contactsController.getFirstName(contact.name),
                          image: AppImages.userImage,
                          isSelected: isSelected,
                          borderColor: isSelected ? Colors.green : Colors.transparent, // Selected border color
                        ),
                      );
                    },
                  ),
                ],
              );
            }),

            const SizedBox(height: 24.0,),

            Obx(() {
              final selectedContactIndex =contactsController.selectedContactIndex.value;
              final selectedContact =contactsController.fetchedContacts[selectedContactIndex];
              final selectedContactName =selectedContact.name;
              final selectedContactNumber =selectedContact.number;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.green,
                      width: 4.0), // Border around the image
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          radius: 32,
                          backgroundImage: AssetImage(AppImages.userImage),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                selectedContactName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.0,),
                            Text(selectedContactNumber)
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: 4.0,),
                    Divider(),
                    SizedBox(height: 4.0,),

                    ///Emergency function buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            // Rounded corners if needed
                            border: Border.all(
                                color: Colors.green[800]!), // Border
                          ),
                          padding: EdgeInsets.all(8),
                          // Adjust padding as needed
                          child: IconButton(
                            onPressed: () async {
                              await FlutterPhoneDirectCaller.callNumber(selectedContactNumber);
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
                            color: AppColors.primary,
                            // Background color
                            borderRadius: BorderRadius.circular(100),
                            // Rounded corners if needed
                            border: Border.all(
                                color: Colors.green[800]!), // Border
                          ),
                          padding: EdgeInsets.all(8),
                          // Adjust padding as needed
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
                            color: AppColors.primary,
                            // Background color
                            borderRadius: BorderRadius.circular(100),
                            // Rounded corners if needed
                            border: Border.all(
                                color: Colors.green[800]!), // Border
                          ),
                          padding: EdgeInsets.all(8),
                          // Adjust padding as needed
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
                  ],
                ),
              );
            }
            ),

            const SizedBox(height: 24.0,),



            const SizedBox(height: 24.0,),
            Divider(),
            const SizedBox(height: 24.0,),
            ElevatedButton(
                onPressed: () {
                  //sosStateController.toggleSOS();
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
