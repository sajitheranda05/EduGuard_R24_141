import 'package:eduguard/src/common_widgets/Screens/circular_image.dart';
import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/personalization/controllers/user_controller.dart';
import 'package:eduguard/src/features/personalization/screens/user_profile.dart';
import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer ({super.key});

  @override
  Widget build(BuildContext context) {
    final userController =UserController.instance;
    return Drawer(
      elevation: 5.0,
      backgroundColor: AppColors.primaryBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children:[
          UserAccountsDrawerHeader(
            accountName: Text(
                userController.user.value.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
            ),
            accountEmail: Text(
              userController.user.value.email,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            currentAccountPicture: const CustomCircularImage(
              image: AppImages.userImage,
              width: 48,
              height: 48,
            ),
            decoration:  BoxDecoration(
              color: AppColors.primary,
            ),
            onDetailsPressed: () {
              Get.to(() => const UserProfile());
            },
            arrowColor: AppColors.primary,
          ),

          ListTile(
            leading: Icon(Icons.home_rounded, color: Colors.teal[900],),
            title: const Text('Emergency SOS System'),
            onTap: () {
              //Get.to(() => const SOSHomePage());
            },
          ),

          ListTile(
            leading: const Icon(Icons.school_rounded),
            title: const Text('Education'),
            onTap: () {
              //Get.to(() => const TestPage());
            },
          ),

          ListTile(
            leading: const Icon(Icons.article_rounded),
            title: const Text('Blogs'),
            onTap: () {
              //Get.to(() => const TestPage());
            },
          ),

          ListTile(
            leading: const Icon(Icons.quiz_rounded),
            title: const Text('Questionnaire'),
            onTap: () {
              //Get.to(() => const TestPage());
            },
          ),

          ListTile(
            leading: const Icon(Icons.medical_information_rounded),
            title: const Text('Health'),
            onTap: () {
              //Get.to(() => const TestPage());
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.manage_accounts_rounded),
            title: const Text('User Profile'),
            onTap: () {
              Get.to(() => const UserProfile());
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Logout'),
            onTap: () {
              AuthenticationRepository.instance.logout();
            },
          ),

        ],
      ),
    );
  }
}
