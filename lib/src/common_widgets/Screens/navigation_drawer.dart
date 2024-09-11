import 'package:eduguard/src/features/authentication/user/login/screens/login_select.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer ({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children:[
          const UserAccountsDrawerHeader(
            accountName: Text('John doe'),
            accountEmail: Text('john.doe@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://plus.unsplash.com/premium_vector-1682269287900-d96e9a6c188b?bg=FFFFFF&q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text('Emergency SOS System'),
            onTap: () {
              //Get.to(() => const SOSHomePage());
            },
          ),

          ListTile(
            leading: const Icon(Icons.school_rounded),
            title: const Text('Eduaction'),
            onTap: () {
              //Get.to(() => const TestPage());
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: const Text('Settings'),
            onTap: () {
              //Get.to(() => const TestPage());
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Logout'),
            onTap: () {
              SharedPreferences.getInstance().then((prefs) {
                prefs.clear();
              });
              // remove autologin data
              final auth =FirebaseAuth.instance;
              auth.signOut();
              Get.offAll(() => const LoginSelectScreen());
            },
          ),

        ],
      ),
    );
  }
}
