import 'package:eduguard/src/features/sos_system/main/screens/sos_home.dart';
import 'package:eduguard/src/features/std_detection/screens/std_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const SOSHomePage(),
    //const TestPage(),
    //const MainScreen(),
    (Container(
      color: Colors.orange,
    )),
    //const PredictionPage(),
    (Container(
      color: Colors.green,
    )),
    (Container(
      color: Colors.red,
    )),
    const STDHomePage(),
  ];
}
