import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHelperFunctions {

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String formatPhoneNumber(String phoneNumber) {
    if(phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0,3)} ${phoneNumber.substring(3,6)} ${phoneNumber.substring(6)})';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0,4)} ${phoneNumber.substring(4,7)} ${phoneNumber.substring(7)})';
    }
    return phoneNumber;
  }

  static String formatTimestamp(DateTime timestamp) {
    // Get hour in 12-hour format
    int hour = timestamp.hour > 12 ? timestamp.hour - 12 : timestamp.hour;
    // Handle the case where hour is 0 (which is 12 AM in 12-hour format)
    hour = hour == 0 ? 12 : hour;

    // Determine AM or PM
    String period = timestamp.hour >= 12 ? 'PM' : 'AM';

    // Return formatted string with AM/PM
    return '$hour:${timestamp.minute.toString().padLeft(2, '0')} $period';
  }

}