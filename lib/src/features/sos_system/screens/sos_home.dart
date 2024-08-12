import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/common_widgets/Screens/tabbar.dart';
import 'package:eduguard/src/features/personalization/controllers/user_controller.dart';
import 'package:eduguard/src/features/sos_system/contacts/screens/sos_edit_contacts.dart';
import 'package:eduguard/src/features/sos_system/screens/sos_settings.dart';
import 'package:eduguard/src/features/sos_system/screens/sos_tab_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SOSHomePage extends StatefulWidget {
  const SOSHomePage({super.key});

  @override
  State<SOSHomePage> createState() => _SOSHomePageState();
}

class _SOSHomePageState extends State<SOSHomePage> {
  @override
  Widget build(BuildContext context) {

    final userController = Get.put(UserController());


    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  'Hello, ${userController.user.value.fullName} ...',
                  style: const TextStyle(
                      fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                      color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              const Text(
                'Emergency SOS System',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                ),
              )
            ],
          ),
          actions: [IconButton(onPressed: () {
            Get.to(() => const SOSSettings());
          }, icon: const Icon(Icons.settings_rounded))],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const CustomTabBar(
                tabs: [
                  Tab(
                    child: Text('SOS'),
                  ),
                  Tab(
                    child: Text('Chat'),
                  ),
                  Tab(
                    child: Text('Location'),
                  ),
                ],
              ),
            ),
            const Expanded(
                child: TabBarView(
              children: [
                Center(
                  child: SOSTabScreen(),
                ),
                Center(
                  child: Text('Content for Chat system'),
                ),
                Center(
                  child: Text('Content for Location system'),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
