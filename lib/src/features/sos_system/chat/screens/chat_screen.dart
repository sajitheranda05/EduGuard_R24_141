import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/sos_system/chat/controllers/chat_controller.dart';
import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:eduguard/src/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatroomScreen extends StatelessWidget {
  final String contactId;
  final String contactName;
  final String userId;

  ChatroomScreen({required this.contactId, required this.userId, required this.contactName});

  @override
  Widget build(BuildContext context) {
    final ChatroomController controller = Get.put(ChatroomController());
    final TextEditingController messageController = TextEditingController(); // Define the TextEditingController

    return FutureBuilder<String?>(
      future: controller.getChatroomId(userId, contactId),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.primaryBackground,
            ),
          );
        }

        final chatroomId = snapshot.data!;

        controller.fetchMessages(chatroomId);

        return Scaffold(
          backgroundColor: AppColors.primaryBackground,
          appBar: CustomAppBar(
            showBackArrow: true,
            title: Text('Chat with $contactName'),
          ),
          body: Column(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                  reverse: true,
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    final isSentByMe = message.senderId == userId;

                    return Align(
                      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: IntrinsicWidth(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSentByMe ? AppColors.primary : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!isSentByMe)
                                  Text(
                                    contactName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                SizedBox(height: 4,),
                                Text(
                                  message.text,
                                  style: TextStyle(
                                    fontSize: 16,
                                      color: isSentByMe ? Colors.black : Colors.black87
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      AppHelperFunctions.formatTimestamp(message.timestamp), // Display the formatted time
                                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                                    ),
                                    SizedBox(width: 8,),
                                    if (isSentByMe)
                                      Icon(
                                        message.readStatus
                                            ? Icons.done_all
                                            : Icons.done,
                                        size: 16,
                                        color: message.readStatus ? Colors.blue : Colors.black54,
                                      ), // Display read status
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController, // Use the defined TextEditingController
                        decoration: const InputDecoration(hintText: 'Type a message'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final text = messageController.text.trim();
                        if (text.isNotEmpty) {
                          controller.sendMessage(chatroomId, userId, contactId, text);
                          messageController.clear(); // Clear the text field after sending the message
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}


// class ChatroomScreen extends StatelessWidget {
//   final String contactId;
//   final String contactName;
//   final String userId;
//
//   ChatroomScreen({required this.contactId, required this.userId, required this.contactName});
//
//   @override
//   Widget build(BuildContext context) {
//     final ChatroomController controller = Get.put(ChatroomController());
//     final TextEditingController messageController = TextEditingController(); // Define the TextEditingController
//
//     return FutureBuilder<String?>(
//       future: controller.getChatroomId(userId, contactId),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData || snapshot.data == null) {
//           return const Center(
//               child: CircularProgressIndicator(
//                 color: AppColors.primary,
//                 backgroundColor: Colors.white,
//               ),
//           );
//         }
//
//         final chatroomId = snapshot.data!;
//
//         controller.fetchMessages(chatroomId);
//
//         return Scaffold(
//           appBar: CustomAppBar(
//             showBackArrow: true,
//             title: Text('Chat with $contactName'),
//           ),
//           body: Column(
//             children: [
//               Expanded(
//                 child: Obx(() => ListView.builder(
//                   reverse: true,
//                   itemCount: controller.messages.length,
//                   itemBuilder: (context, index) {
//                     final message = controller.messages[index];
//                     final isSentByMe = message.senderId == userId;
//
//                     return Align(
//                       alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: isSentByMe ? AppColors.primary : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (!isSentByMe)
//                               Text(
//                                 contactName,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                             Text(
//                               message.text,
//                               style: TextStyle(color: isSentByMe ? Colors.black : Colors.black87),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 )),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: messageController, // Use the defined TextEditingController
//                         decoration: InputDecoration(hintText: 'Type a message'),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.send),
//                       onPressed: () {
//                         final text = messageController.text.trim();
//                         if (text.isNotEmpty) {
//                           controller.sendMessage(chatroomId, userId, text);
//                           messageController.clear(); // Clear the text field after sending the message
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
