import 'package:eduguard/src/common_widgets/controllers/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(NavigationController());

    return Obx(
          () => NavigationBar(
        height: 80.0,
        elevation: 0,
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: (index) => controller.selectedIndex.value =index,
        backgroundColor: Colors.white,
        indicatorColor: Colors.grey.withOpacity(0.2),
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.school_rounded), label: 'Education'),
          NavigationDestination(icon: Icon(Icons.article_rounded), label: 'Blogs'),
          NavigationDestination(icon: Icon(Icons.quiz_rounded), label: 'Quiz'),
          NavigationDestination(icon: Icon(Icons.medical_information_rounded), label: 'Health'),
        ],
      ),
    );
    //body: Obx(() => controller.screens[controller.selectedIndex.value]),
  }
}

