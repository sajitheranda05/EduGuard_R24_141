import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/common_widgets/Screens/tabbar.dart';
import 'package:eduguard/src/features/personalization/controllers/user_controller.dart';
import 'package:eduguard/src/features/sos_system/chat/screens/sos_all_chats.dart';
import 'package:eduguard/src/features/sos_system/contacts/screens/sos_settings.dart';
import 'package:eduguard/src/features/sos_system/location/screens/map_tab_section.dart';
import 'package:eduguard/src/features/sos_system/main/screens/sos_tab_section.dart';
import 'package:eduguard/src/features/sos_system/sos_state/controllers/wakeword_controller.dart';
import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SOSHomePage extends StatefulWidget {
  const SOSHomePage({super.key});

  @override
  State<SOSHomePage> createState() => _SOSHomePageState();
}

class _SOSHomePageState extends State<SOSHomePage> {
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final wakeWordController =Get.put(CommandController());

    //Initialize picovoice
    wakeWordController.initPicovoice();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
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
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const SOSSettings());
                },
                icon: const Icon(Icons.supervised_user_circle_sharp))
          ],
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
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const Center(
                    child: SOSTabScreen(),
                  ),
                  const Center(
                    child: SOSAllChatsScreen(),
                  ),
                  Center(
                    child: SOSMapPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
