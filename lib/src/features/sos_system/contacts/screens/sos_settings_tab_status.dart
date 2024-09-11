import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/sos_system/contacts/controllers/invite_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/invite_model.dart';
import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SOSSettingsTabStatus extends StatelessWidget {
  const SOSSettingsTabStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final InviteController inviteController = Get.put(InviteController());
    final userId = AuthenticationRepository.instance.authUser!.uid;

    // Fetch invites when the screen is initialized
    inviteController.fetchInvites(userId);

    return Scaffold(
      body: Column(
        children: [

          // Sent Invites (Tracking Status)
          Expanded(
            child: Obx(() {
              if (inviteController.sentInvites.isEmpty) {
                return const Center(child: Text('No sent invites.'));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16,),
                    Expanded(
                      child: ListView.builder(
                        itemCount: inviteController.sentInvites.length,
                        itemBuilder: (context, index) {
                          InviteModel invite = inviteController.sentInvites[index];
                          return ListTile(
                            title: Text(invite.name),
                            subtitle: Text('Invite to ${invite.email}'),
                            trailing: Text(
                              invite.inviteStatus,
                              style: TextStyle(
                                color: invite.inviteStatus == 'accepted'
                                    ? Colors.green
                                    : invite.inviteStatus == 'rejected'
                                    ? Colors.red
                                    : Colors.orange,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }),
          ),


          // Pending Invites (Received)
          Expanded(
            child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Received Invites', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: inviteController.pendingInvites.length,
                        itemBuilder: (context, index) {
                          InviteModel invite = inviteController.pendingInvites[index];
                          return ListTile(
                            title: Text(invite.name),
                            subtitle: Text('Invite from ${invite.email}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.check_circle, color: AppColors.primary),
                                  onPressed: () {
                                    inviteController.acceptInvite(userId, invite);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close_rounded, color: Colors.red),
                                  onPressed: () {
                                    inviteController.rejectInvite(userId, invite);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
            }),
          ),

        ],
      ),
    );
  }
}
