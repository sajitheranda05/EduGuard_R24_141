import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/contact_repository.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/contacts_model.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/user_search_model.dart';
import 'package:eduguard/src/utils/network_manager.dart';
import 'package:eduguard/src/utils/popups/full_screen_loader.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ContactSettingsController extends GetxController {
  static ContactSettingsController get instance => Get.find();

  RxList<UserSearchModel> searchResultsForHighPriorityContact = <UserSearchModel>[].obs;
  RxList<UserSearchModel> searchResultsForContactOne = <UserSearchModel>[].obs;
  RxList<UserSearchModel> searchResultsForContactTwo = <UserSearchModel>[].obs;
  RxList<UserSearchModel> searchResultsForContactThree = <UserSearchModel>[].obs;

  final highPriorityContactEmail =TextEditingController().obs;
  final highPriorityContactName = TextEditingController().obs;
  final highPriorityContactNumber = TextEditingController().obs;

  final contactOneEmail =TextEditingController().obs;
  final contactOneName = TextEditingController().obs;
  final contactOneNumber = TextEditingController().obs;

  final contactTwoEmail =TextEditingController().obs;
  final contactTwoName = TextEditingController().obs;
  final contactTwoNumber = TextEditingController().obs;

  final contactThreeEmail =TextEditingController().obs;
  final contactThreeName = TextEditingController().obs;
  final contactThreeNumber = TextEditingController().obs;

  var usedEmails =<String>[].obs;

  Rx<ContactsModel> contacts =ContactsModel.empty().obs;
  final contactRepository =Get.put(ContactRepository());
  GlobalKey<FormState> contactSettingsFormKey =GlobalKey<FormState>();

  @override
  void onInit() async{
    super.onInit();
    //await fetchContactsRecord();
    //initializeContacts();
  }

  // //Populate Text fields
  // Future<void> initializeContacts() async {
  //   highPriorityContactEmail.value.text =contacts.value.highPriorityContactEmail;
  //   contactOneEmail.value.text =contacts.value.contactOneEmail;
  //   contactTwoEmail.value.text =contacts.value.contactTwoEmail;
  //   contactThreeEmail.value.text =contacts.value.contactThreeEmail;
  // }

  // //fetch contacts
  // Future<void> fetchContactsRecord() async {
  //   try {
  //     final contacts =await contactRepository.fetchContactsDetails();
  //     this.contacts(contacts);
  //   } catch (e) {
  //     contacts(ContactsModel.empty());
  //   }
  // }

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
        highPriorityContactName: '',
        contactOneName: '',
        contactTwoName: '',
        contactThreeName: '',
        highPriorityContactNumber: '',
        contactOneNumber: '',
        contactTwoNumber: '',
        contactThreeNumber: '',
      );

      //Fetch contact records after saving
      //await fetchContactsRecord();
      AppFullScreenLoader.stopLoading();

      AppSnackBars.successSnackBar(title: 'Successful...', message: 'Your contact settings added successfully.');

    } catch(error) {
      AppSnackBars.errorSnackBar(title: 'Oh snap!', message: error.toString());
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

  //Fetch contact numbers
  Future<void> fetchContactsNumbers(String query) async{
    try{
      if(query.isEmpty){
        return;
      }
    }catch(e) {

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

  //Assign priority email to text field
  void assignHighPriorityContactEmailToTextField(String selectedEmail) {
    if(!isEmailUsed(selectedEmail)){
      highPriorityContactEmail.value.text= selectedEmail;
      highPriorityContactEmail.refresh();
      usedEmails.add(selectedEmail);
      searchResultsForHighPriorityContact.clear();
    } else {
      AppSnackBars.errorSnackBar(
          title: 'Error',
          message: 'This email has already been selected.'
      );
    }
  }

  //Assign contact email to text field
  void assignContactOneEmailToTextField(String selectedEmail) {
    if(!isEmailUsed(selectedEmail)){
      contactOneEmail.value.text= selectedEmail;
      contactOneEmail.refresh();
      usedEmails.add(selectedEmail);
      searchResultsForContactOne.clear();
    } else {
      AppSnackBars.errorSnackBar(
          title: 'Error',
          message: 'This email has already been selected.'
      );
    }
  }

  //Assign contact email to text field
  void assignContactTwoEmailToTextField(String selectedEmail) {
    if(!isEmailUsed(selectedEmail)){
      contactTwoEmail.value.text= selectedEmail;
      contactTwoEmail.refresh();
      usedEmails.add(selectedEmail);
      searchResultsForContactTwo.clear();
    } else {
      AppSnackBars.errorSnackBar(
          title: 'Error',
          message: 'This email has already been selected.'
      );
    }
  }

  //Assign contact email to text field
  void assignContactThreeEmailToTextField(String selectedEmail) {
    if(!isEmailUsed(selectedEmail)){
      contactThreeEmail.value.text= selectedEmail;
      contactThreeEmail.refresh();
      usedEmails.add(selectedEmail);
      searchResultsForContactThree.clear();
    } else {
      AppSnackBars.errorSnackBar(
          title: 'Error',
          message: 'This email has already been selected.'
      );
    }
  }


}



