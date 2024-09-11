import 'package:eduguard/src/features/sos_system/screens/education_screen.dart';
import 'package:eduguard/src/features/sos_system/screens/sos_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex =0.obs;

  final screens = [
    const SOSHomePage(),
    //const TestPage(),
    //const MainScreen(),
    const EducationScreen(),
    //const PredictionPage(),
    (Container(color: Colors.green,)),
    (Container(color: Colors.red,)),
    (Container(color: Colors.blue,)),
    (Container(color: Colors.purple,)),
  ];
}