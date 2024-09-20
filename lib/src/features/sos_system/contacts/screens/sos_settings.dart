import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/common_widgets/Screens/tabbar.dart';
import 'package:eduguard/src/features/sos_system/contacts/controllers/contacts_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/models/contacts_model.dart';
import 'package:eduguard/src/features/sos_system/contacts/screens/sos_edit_contacts.dart';
import 'package:eduguard/src/features/sos_system/contacts/screens/sos_settings_tab_contacts.dart';
import 'package:eduguard/src/features/sos_system/contacts/screens/sos_settings_tab_invite.dart';
import 'package:eduguard/src/features/sos_system/contacts/screens/sos_settings_tab_status.dart';
import 'package:eduguard/src/features/sos_system/sos_common_widgets/sos_title_card.dart';
import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SOSSettings extends StatelessWidget {
  const SOSSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final contactsController =Get.put(ContactsController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        appBar: const CustomAppBar(
          showBackArrow: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            children: [

              const CustomSOSTitleCard(
                title:'Emergency Contacts',
                subtitle: 'This is the section for the emergency contact settings.',
              ),


              Container(
                child: const CustomTabBar(
                  tabs: [
                    Tab(
                      child: Text('Contacts'),
                    ),
                    Tab(
                      child: Text('Invite'),
                    ),
                    Tab(
                      child: Text('Status'),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const Center(
                      child: SOSSettingsTabContacts(),
                    ),
                    Center(
                      child: SOSSettingsTabInvite(),
                    ),
                    const Center(
                      child: SOSSettingsTabStatus(),
                    ),
                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}