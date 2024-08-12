import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/contact_repository.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/contacts_model.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/user_search_model.dart';
import 'package:eduguard/src/utils/network_manager.dart';
import 'package:eduguard/src/utils/popups/full_screen_loader.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  static ContactsController get instance => Get.find();

  RxList<UserSearchModel> searchResultsForHighPriorityContact = <UserSearchModel>[].obs;
  RxList<UserSearchModel> searchResultsForContactOne = <UserSearchModel>[].obs;
  RxList<UserSearchModel> searchResultsForContactTwo = <UserSearchModel>[].obs;
  RxList<UserSearchModel> searchResultsForContactThree = <UserSearchModel>[].obs;

  // Controllers for email fields
  final highPriorityContactEmail = TextEditingController().obs;
  final contactOneEmail = TextEditingController().obs;
  final contactTwoEmail = TextEditingController().obs;
  final contactThreeEmail = TextEditingController().obs;

  // Additional controllers for name and contact number fields
  final highPriorityContactName = TextEditingController().obs;
  final highPriorityContactNumber = TextEditingController().obs;

  final contactOneName = TextEditingController().obs;
  final contactOneNumber = TextEditingController().obs;

  final contactTwoName = TextEditingController().obs;
  final contactTwoNumber = TextEditingController().obs;

  final contactThreeName = TextEditingController().obs;
  final contactThreeNumber = TextEditingController().obs;

  var usedEmails =<String>[].obs;

  Rx<ContactsModel> contacts =ContactsModel.empty().obs;
  final contactRepository =Get.put(ContactRepository());
  GlobalKey<FormState> contactSettingsFormKey =GlobalKey<FormState>();

  RxList<ContactsModel> fetchedContacts = <ContactsModel>[].obs;

  @override
  void onInit() async{
    super.onInit();
    //await fetchContactsRecord();
    await fetchContactDetails();
    initializeContacts();
  }

  // Method to initialize contact fields
  Future<void> initializeContacts() async {

    final highPriorityContact = fetchedContacts.firstWhere(
          (c) => c.priority == 'high',
      orElse: () => ContactsModel.empty(),
    );
    highPriorityContactEmail.value.text = highPriorityContact.email;
    highPriorityContactName.value.text = highPriorityContact.name;
    highPriorityContactNumber.value.text = highPriorityContact.number;

    final contactOne = fetchedContacts.firstWhere(
          (c) => c.priority == 'lowOne',
      orElse: () => ContactsModel.empty(),
    );
    contactOneEmail.value.text = contactOne.email;
    contactOneName.value.text = contactOne.name;
    contactOneNumber.value.text = contactOne.number;

    final contactTwo = fetchedContacts.firstWhere(
          (c) => c.priority == 'lowTwo',
      orElse: () => ContactsModel.empty(),
    );
    contactTwoEmail.value.text = contactTwo.email;
    contactTwoName.value.text = contactTwo.name;
    contactTwoNumber.value.text = contactTwo.number;

    final contactThree = fetchedContacts.firstWhere(
          (c) => c.priority == 'lowThree',
      orElse: () => ContactsModel.empty(),
    );
    contactThreeEmail.value.text = contactThree.email;
    contactThreeName.value.text = contactThree.name;
    contactThreeNumber.value.text = contactThree.number;
  }

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

      // Controllers are refreshed to capture the latest values
      contactOneEmail.refresh();
      contactTwoEmail.refresh();
      contactThreeEmail.refresh();
      highPriorityContactEmail.refresh();

      await contactRepository.saveContactsRecord(
        highPriorityContactEmail: highPriorityContactEmail.value.text.trim(),
        contactOneEmail: contactOneEmail.value.text.trim(),
        contactTwoEmail: contactTwoEmail.value.text.trim(),
        contactThreeEmail: contactThreeEmail.value.text.trim(),
        highPriorityContactName: highPriorityContactName.value.text.trim(),
        contactOneName: contactOneName.value.text.trim(),
        contactTwoName: contactTwoName.value.text.trim(),
        contactThreeName: contactThreeName.value.text.trim(),
        highPriorityContactNumber: contactOneNumber.value.text.trim(),
        contactOneNumber: contactOneNumber.value.text.trim(),
        contactTwoNumber: contactTwoNumber.value.text.trim(),
        contactThreeNumber: contactThreeNumber.value.text.trim(),
      );

      //Fetch contact records after saving
      await fetchContactDetails();
      AppFullScreenLoader.stopLoading();

      AppSnackBars.successSnackBar(title: 'Successful...', message: 'Your contact settings added successfully.');

    } catch(error) {
      AppSnackBars.errorSnackBar(title: 'Oh snap!', message: error.toString());
    }
  }

  //Add selected emails to used emails
  bool isEmailUsed(String email) {
    return usedEmails.contains(email);
  }

  //Remove emails from used emails
  void removeEmailFromUsedEmails(String email) {
    usedEmails.remove(email);
  }

  // Method to clear text field and remove email from usedEmails
  void clearEmailField(Rx<TextEditingController> controller) async{
    if (controller.value.text.isNotEmpty) {
      removeEmailFromUsedEmails(controller.value.text);
      controller.value.clear();
      controller.refresh();
    }
  }

  // Assign email and populate additional fields
  void assignHighPriorityContactEmailToTextField(String selectedEmail) {
    if (!isEmailUsed(selectedEmail)) {
      highPriorityContactEmail.value.text = selectedEmail;
      // Fetch and populate name and contact number based on the email
      fetchAndPopulateContactDetails(selectedEmail, highPriorityContactName, highPriorityContactNumber);
      usedEmails.add(selectedEmail);
      searchResultsForHighPriorityContact.clear();
    } else {
      AppSnackBars.errorSnackBar(
        title: 'Error',
        message: 'This email has already been selected.',
      );
    }
  }

  // Assign email and populate additional fields
  void assignContactOneEmailToTextField(String selectedEmail) {
    if (!isEmailUsed(selectedEmail)) {
      contactOneEmail.value.text = selectedEmail;
      // Fetch and populate name and contact number based on the email
      fetchAndPopulateContactDetails(selectedEmail, contactOneName, contactOneNumber);
      usedEmails.add(selectedEmail);
      searchResultsForContactOne.clear();
    } else {
      AppSnackBars.errorSnackBar(
        title: 'Error',
        message: 'This email has already been selected.',
      );
    }
  }

  // Assign email and populate additional fields
  void assignContactTwoEmailToTextField(String selectedEmail) {
    if (!isEmailUsed(selectedEmail)) {
      contactTwoEmail.value.text = selectedEmail;
      // Fetch and populate name and contact number based on the email
      fetchAndPopulateContactDetails(selectedEmail, contactTwoName, contactTwoNumber);
      usedEmails.add(selectedEmail);
      searchResultsForContactTwo.clear();
    } else {
      AppSnackBars.errorSnackBar(
        title: 'Error',
        message: 'This email has already been selected.',
      );
    }
  }

  // Assign email and populate additional fields
  void assignContactThreeEmailToTextField(String selectedEmail) {
    if (!isEmailUsed(selectedEmail)) {
      contactThreeEmail.value.text = selectedEmail;
      // Fetch and populate name and contact number based on the email
      fetchAndPopulateContactDetails(selectedEmail, contactThreeName, contactThreeNumber);
      usedEmails.add(selectedEmail);
      searchResultsForContactThree.clear();
    } else {
      AppSnackBars.errorSnackBar(
        title: 'Error',
        message: 'This email has already been selected.',
      );
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

  //Search Users for High Priority contact
  Future<void> searchUsersForHighPriorityContact(String query) async {
    try {

      if (query.isEmpty) {
        searchResultsForHighPriorityContact.clear();
        return;
      }

      QuerySnapshot<Map<String, dynamic>> result = await contactRepository.searchUsers(query);
      searchResultsForHighPriorityContact.clear();

      searchResultsForHighPriorityContact.addAll(result.docs.map((doc) {
        return UserSearchModel.fromSnapshot(doc);
      }).where((user) =>
      user.fullName.toLowerCase().contains(query.toLowerCase()) || user.email.toLowerCase().contains(query.toLowerCase())
      ).toList());

    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Search Error', message: 'Something went wrong while searching for users.');
    }
  }

  //Search Users for Contact one
  Future<void> searchUsersForContactOne(String query) async {
    try {

      if (query.isEmpty) {
        searchResultsForContactOne.clear();
        return;
      }

      QuerySnapshot<Map<String, dynamic>> result = await contactRepository.searchUsers(query);
      searchResultsForContactOne.clear();

      searchResultsForContactOne.addAll(result.docs.map((doc) {
        return UserSearchModel.fromSnapshot(doc);
      }).where((user) =>
      user.fullName.toLowerCase().contains(query.toLowerCase()) || user.email.toLowerCase().contains(query.toLowerCase())
      ).toList());

    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Search Error', message: 'Something went wrong while searching for users.');
    }
  }

  //Search Users for Contact two
  Future<void> searchUsersForContactTwo(String query) async {
    try {

      if (query.isEmpty) {
        searchResultsForContactTwo.clear();
        return;
      }

      QuerySnapshot<Map<String, dynamic>> result = await contactRepository.searchUsers(query);
      searchResultsForContactTwo.clear();

      searchResultsForContactTwo.addAll(result.docs.map((doc) {
        return UserSearchModel.fromSnapshot(doc);
      }).where((user) =>
      user.fullName.toLowerCase().contains(query.toLowerCase()) || user.email.toLowerCase().contains(query.toLowerCase())
      ).toList());

    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Search Error', message: 'Something went wrong while searching for users.');
    }
  }

  //Search Users for Contact three
  Future<void> searchUsersForContactThree(String query) async {
    try {

      if (query.isEmpty) {
        searchResultsForContactThree.clear();
        return;
      }

      QuerySnapshot<Map<String, dynamic>> result = await contactRepository.searchUsers(query);
      searchResultsForContactThree.clear();

      searchResultsForContactThree.addAll(result.docs.map((doc) {
        return UserSearchModel.fromSnapshot(doc);
      }).where((user) =>
      user.fullName.toLowerCase().contains(query.toLowerCase()) || user.email.toLowerCase().contains(query.toLowerCase())
      ).toList());

    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Search Error', message: 'Something went wrong while searching for users.');
    }
  }
}