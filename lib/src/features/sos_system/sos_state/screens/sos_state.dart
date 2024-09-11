import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/sos_system/chat/screens/chat_screen.dart';
import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/features/sos_system/location/controllers/map_controller.dart';
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
    final mapController =Get.put(MapController());
    final contactsController = Get.find<ContactsController>();

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SOS Activated...',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        sosStateController.secondsRemaining.value == 0
                            ? const Text('Contacts Notified')
                            : Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Notifying Emergency Contacts in ',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${sosStateController.secondsRemaining.value} seconds...',
                                      style: TextStyle(
                                        color: sosStateController
                                                    .secondsRemaining.value <=
                                                4
                                            ? Colors.red
                                            : Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 48.0),
                  ElevatedButton(
                    onPressed: () {
                      sosStateController.cancelCountdown();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: const Text('Deactivate'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8.0),
            const Divider(),
            const SizedBox(height: 8.0),

            Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    sosStateController.isCanceled.value
                        ? const Text('Call Canceled')
                        : const Text('Calling High priority contact '),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${sosStateController.callCountdownSecondsRemaining.value}',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Seconds',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    if (!sosStateController.isCanceled.value)
                      OutlinedButton(
                        onPressed: () {
                          sosStateController.cancelCountdown();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text('Cancel'),
                      ),

                  ],
                );
              }
            ),

            const SizedBox(
              height: 8.0,
            ),
            const Divider(),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Emergency Contacts',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Text(
              'All the emergency functions will be defaulted to high priority contact.',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    contactsController.fetchedContacts.length,
                    (index) {
                      var contact = contactsController.fetchedContacts[index];
                      bool isSelected =
                          contactsController.selectedContactIndex.value ==
                              index;

                      return GestureDetector(
                        onTap: () {
                          contactsController.selectContact(index);
                        },
                        child: CustomSOSUSerImageSection(
                          contactName:
                              contactsController.getFirstName(contact.name),
                          image: AppImages.userImage,
                          isSelected: isSelected,
                          borderColor: isSelected
                              ? Colors.green
                              : Colors.transparent, // Selected border color
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 8.0,
            ),
            Obx(() {
              final selectedContactIndex = contactsController.selectedContactIndex.value;
              final selectedContact = contactsController.fetchedContacts[selectedContactIndex];
              final selectedContactName = selectedContact.name;
              final selectedContactNumber = selectedContact.number;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                      color: Colors.green,
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
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(selectedContactNumber)
                          ],
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 4.0,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 4.0,
                    ),

                    //Emergency function buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: AppColors.primary), // Border
                          ),
                          padding: const EdgeInsets.all(8),
                          child: IconButton(
                            onPressed: () async {
                              await FlutterPhoneDirectCaller.callNumber(
                                  selectedContactNumber);
                            },
                            icon: Icon(
                              Icons.call,
                              size: 32,
                              color: Colors.white, // Icon color
                            ),
                          ),
                        ),


                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: AppColors.primary), // Border
                          ),
                          padding: const EdgeInsets.all(8),
                          // Adjust padding as needed
                          child: IconButton(
                            onPressed: () {
                              sosStateController.handleSOSChat(selectedContact.id, selectedContactName);
                            },
                            icon: Icon(
                              Icons.chat,
                              size: 32,
                              color: Colors.white, // Icon color
                            ),
                          ),
                        ),


                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: AppColors.primary), // Border
                          ),
                          padding: const EdgeInsets.all(8),
                          // Adjust padding as needed
                          child: IconButton(
                            onPressed: () async {
                              await mapController.storeUserLocation();
                            },
                            icon: Icon(
                              Icons.location_on,
                              size: 32,
                              color: Colors.white, // Icon color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 24.0),
            const Divider(),
            const SizedBox(height: 8.0),

            //False alarm recognition model state
            AudioState(),
          ],
        ),
      ),
    );
  }
}
