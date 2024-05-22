
import 'package:eduguard/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();
  final pageController =PageController();
  Rx<int> currentPageIndex =0.obs;

  //Update current index when page scroll
  void updatePageIndicator(index) {
    currentPageIndex.value =index;
  }

  //Jump to the specific dot selected page
  void dotNavigationOnClick(index) {
    currentPageIndex.value =index;
    pageController.jumpTo(index);
  }

  //Update current index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 4) {
      Get.to(() => const BottomNavigationMenu());
    }else{
      int page =currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  //Update the current index and & jump to the last page
  void skipPage() {
    currentPageIndex.value =4;
    pageController.jumpToPage(4);
  }

}