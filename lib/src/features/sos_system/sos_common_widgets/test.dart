// import 'package:eduguard/src/features/sos_system/contacts/models/user_search_model.dart';
// import 'package:eduguard/src/features/sos_system/main/controllers/sos_edit_settings_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ContactSettingsScreen extends StatelessWidget {
//   final ContactSettingsController contactSettingsController = Get.put(ContactSettingsController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contact Test Settings'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: contactSettingsController.contactSettingsFormKey,
//           child: Column(
//             children: [
//               // High Priority Contact Email
//               buildEmailField(
//                 label: 'High Priority Contact Email',
//                 controller: contactSettingsController.highPriorityContactEmail,
//                 searchResults: contactSettingsController.searchResultsForHighPriorityContact,
//                 onSearch: contactSettingsController.searchUsersForHighPriorityContact,
//                 onAssign: contactSettingsController.assignHighPriorityContactEmailToTextField,
//               ),
//               SizedBox(height: 16),
//
//               // Contact One Email
//               buildEmailField(
//                 label: 'Contact One Email',
//                 controller: contactSettingsController.contactOneEmail,
//                 searchResults: contactSettingsController.searchResultsForContactOne,
//                 onSearch: contactSettingsController.searchUsersForContactOne,
//                 onAssign: contactSettingsController.assignContactOneEmailToTextField,
//               ),
//               SizedBox(height: 16),
//
//               // Contact Two Email
//               buildEmailField(
//                 label: 'Contact Two Email',
//                 controller: contactSettingsController.contactTwoEmail,
//                 searchResults: contactSettingsController.searchResultsForContactTwo,
//                 onSearch: contactSettingsController.searchUsersForContactTwo,
//                 onAssign: contactSettingsController.assignContactTwoEmailToTextField,
//               ),
//               SizedBox(height: 16),
//
//               // Contact Three Email
//               buildEmailField(
//                 label: 'Contact Three Email',
//                 controller: contactSettingsController.contactThreeEmail,
//                 searchResults: contactSettingsController.searchResultsForContactThree,
//                 onSearch: contactSettingsController.searchUsersForContactThree,
//                 onAssign: contactSettingsController.assignContactThreeEmailToTextField,
//               ),
//               SizedBox(height: 24),
//
//               // Save Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: contactSettingsController.saveContactSettings,
//                   child: Text('Save Settings'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildEmailField({
//     required String label,
//     required Rx<TextEditingController> controller,
//     required RxList<UserSearchModel> searchResults,
//     required Function(String) onSearch,
//     required Function(String) onAssign,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Obx(
//               () => TextFormField(
//             controller: controller.value,
//             validator: (value) => value?.isEmpty ?? true ? 'Please enter an email' : null,
//             decoration: InputDecoration(
//               labelText: label,
//               suffixIcon: controller.value.text.isNotEmpty
//                   ? IconButton(
//                 icon: Icon(Icons.clear),
//                 onPressed: () => contactSettingsController.clearEmailField(controller),
//               )
//                   : null,
//             ),
//             onChanged: (value) => onSearch(value),
//           ),
//         ),
//         Obx(() {
//           if (searchResults.isEmpty) {
//             return SizedBox.shrink(); // No results to display
//           }
//
//           return Container(
//             constraints: BoxConstraints(maxHeight: 200),
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: searchResults.length,
//               itemBuilder: (context, index) {
//                 final user = searchResults[index];
//                 return ListTile(
//                   title: Text(user.fullName),
//                   subtitle: Text(user.email),
//                   onTap: () => onAssign(user.email),
//                 );
//               },
//             ),
//           );
//         }),
//       ],
//     );
//   }
// }