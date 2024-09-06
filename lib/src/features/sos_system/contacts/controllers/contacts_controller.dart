import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/data/repositories/contact_repository.dart';
import 'package:eduguard/src/data/repositories/user_repository.dart';
import 'package:eduguard/src/features/sos_system/chat/controllers/chat_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/controllers/invite_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/contacts_model.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/invite_model.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/user_search_model.dart';
import 'package:eduguard/src/features/sos_system/contacts/screens/sos_settings.dart';
import 'package:eduguard/src/utils/network_manager.dart';
import 'package:eduguard/src/utils/popups/full_screen_loader.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  static ContactsController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final InviteController inviteController =Get.put(InviteController());
  final ContactRepository contactRepository =Get.put(ContactRepository());
  final ChatroomController chatController =Get.put(ChatroomController());

  final String? userId =AuthenticationRepository.instance.authUser?.uid;
  final String? userEmail = AuthenticationRepository.instance.authUser?.email;
  final email = TextEditingController();

  RxList<UserSearchModel> searchResults = <UserSearchModel>[].obs;
  RxList<UserSearchModel> selectedUsers = <UserSearchModel>[].obs;
  Rx<ContactsModel> contacts =ContactsModel.empty().obs;
  RxList<ContactsModel> fetchedContacts = <ContactsModel>[].obs;
  var selectedContactIndex =(0).obs;
  //var  selectedContactIndex;
  var highPriorityContact = ''.obs;

  GlobalKey<FormState> contactSettingsFormKey =GlobalKey<FormState>();

  @override
  void onInit() async{
    super.onInit();
    await fetchContactDetails();
    await setSelectedContact();
    searchResults.clear();

  }

  void setHighPriorityContact(String? email) async {
    try {

      // Check if there is any contact with high priority in the fetchedContacts list
      bool hasHighPriorityContact = fetchedContacts.any((contact) => contact.priority == 'high');

      // If there's an existing high-priority contact, set its priority to 'low'
      if (hasHighPriorityContact) {
        final existingHighPriorityContact = fetchedContacts.firstWhere((contact) => contact.priority == 'high');

        await FirebaseFirestore.instance
            .collection('EmergencyContacts')
            .doc(userId)
            .collection('Contacts')
            .doc(existingHighPriorityContact.id)
            .update({'priority': 'low'});
      }

      // Find the contact that matches the provided email
      final contact = fetchedContacts.firstWhere((contact) => contact.email == email);

      String? contactId = contact.id;

      // Update the priority of the contact
      await FirebaseFirestore.instance
          .collection('EmergencyContacts')
          .doc(userId)
          .collection('Contacts')
          .doc(contactId)
          .update({'priority': 'high'});

      await fetchContactDetails();

      AppSnackBars.successSnackBar(
          title: 'Success...',
          message: 'High priority contact saved successfully.'
      );

    } catch (error) {
      if (kDebugMode) {
        print('Error setting high priority contact: $error');
      }
    }
  }

  //set selected contact to high priority contact
  Future<void> setSelectedContact() async {
    try {
      // If no contact is selected, select the high-priority contact or the first one
      if (fetchedContacts.isNotEmpty) {
        // Find the high-priority contact, or default to the first contact
        int highPriorityIndex = fetchedContacts.indexWhere((contact) => contact.priority == 'high');

        if (highPriorityIndex != -1) {
          selectedContactIndex.value = highPriorityIndex;
        } else {
          selectedContactIndex.value = 0;
        }
      }

    } catch(error) {
      if (kDebugMode) {
        print('Error setting selected contact :  $error');
      }
    }
  }

//select contact
  void selectContact(int index) {
    selectedContactIndex.value =index;
  }

  //Split the fetched full name
  String getFirstName(String fullName) {
    List<String> parts = fullName.split(' ');
    return parts.isNotEmpty ? parts[0] : '';
  }

  //fetch contact details
  Future<void> fetchContactDetails() async {
    try {
      final contactsList = await ContactRepository().fetchContactsDetails();
      fetchedContacts.value = contactsList;
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

  //Save contact settings
  void saveContactSettings() async{
    try {
      //Start Loader
      AppFullScreenLoader.openLoadingDialog('We are processing your information...');

      //check network connectivity
      final isConnected =await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      //Form validation
      if(contactSettingsFormKey.currentState!.validate()) {
        contactSettingsFormKey.currentState!.save();
      }else{
        AppFullScreenLoader.stopLoading();
        return;
      }

      //Fetch contact records after saving
      await fetchContactDetails();

      //Update chat contacts after updating emergency contacts
      chatController.fetchContacts();

      AppFullScreenLoader.stopLoading();

      AppSnackBars.successSnackBar(title: 'Successful...', message: 'Your contact settings added successfully.');

      //Redirect to SOS settings page
      Get.off(() => const SOSSettings());

    } catch(error) {
      AppSnackBars.errorSnackBar(title: 'Oh snap!', message: error.toString());
    }
  }


  void fetchAndPopulateContactDetails(
      String email,
      Rx<TextEditingController> nameController,
      Rx<TextEditingController> numberController
      ) async {
    try {
      final userDetails = await contactRepository.getUserDetailsByEmail(email);
      nameController.value.text = userDetails.fullName;
      numberController.value.text = userDetails.contactNumber;
      nameController.refresh();
      numberController.refresh();
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Error', message: 'Failed to fetch contact details.');
    }
  }

  //Search users to invite as emergency contacts
  Future<void> searchUsers(String query) async {
    try {
      if (query.isEmpty) {
        searchResults.clear();
        return;
      }

      QuerySnapshot<Map<String, dynamic>> result = await userRepository.searchUsers(query);
      searchResults.clear();

      searchResults.addAll(result.docs.map((doc) {
        return UserSearchModel.fromSnapshot(doc);
      }).where((user) =>
      user.fullName.toLowerCase().contains(query.toLowerCase()) ||
          user.email.toLowerCase().contains(query.toLowerCase())
      ).toList());
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Search Error', message: 'Something went wrong while searching for users.');
    }
  }

  //Assign selected email to text field
  void assignEmailToTextField(String assignedEmail) {
    email.text = assignedEmail;
    searchResults.clear();
  }

  //Add email to selected users list
  void addUserToList(UserSearchModel user) async {
    if (user.email == userEmail) {
      AppSnackBars.errorSnackBar(title: 'Cannot add your own email as an emergency contact.');
    } else if (await inviteController.isEmailAlreadyInvited(userId!, user.email)) {
      AppSnackBars.errorSnackBar(title: 'This user has already been invited.');
    } else if (selectedUsers.contains(user)) {
      AppSnackBars.errorSnackBar(title: 'This user is already in the list.');
    } else if (selectedUsers.length >= 4) {
      AppSnackBars.errorSnackBar(title: 'You can only add up to four emergency contacts.');
    } else {
      selectedUsers.add(user);
    }
  }

  //Remove email from selected users list
  void removeUserFromList(UserSearchModel user) {
    selectedUsers.remove(user);
  }

  //Send invitations to the selected users
  void sendInvites() async {
    if (selectedUsers.isEmpty) {
      AppSnackBars.errorSnackBar(title: 'No users selected to invite.');
      return;
    }

    final existingInvitesCount = await FirebaseFirestore.instance
        .collection('EmergencyContacts')
        .doc(userId!)
        .collection('SentInvites')
        .get()
        .then((snapshot) => snapshot.docs.length);

    if (existingInvitesCount + selectedUsers.length > 4) {
      AppSnackBars.errorSnackBar(title: 'You can only send a total of 4 invites.');
      return;
    }

    try {
      for (var user in selectedUsers) {
        // Create a new InviteModel instance
        InviteModel invite = InviteModel(
          id: user.id,
          email: user.email,
          name: user.fullName,
          number: user.contactNumber,
          inviteStatus: 'pending', // Set the invite status to 'pending'
        );

        // Send the invite using InviteController
        await inviteController.sendInvite(userId!, invite);
      }

      AppSnackBars.successSnackBar(title: 'Invites sent successfully.');
      selectedUsers.clear();
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Failed to send invites. Please try again.');
    }
  }




}