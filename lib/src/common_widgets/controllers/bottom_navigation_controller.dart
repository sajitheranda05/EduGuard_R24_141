import 'package:eduguard/src/features/blogs/Screen/bloghome.dart';
import 'package:eduguard/src/features/questionnaire/screens/questionnairehome.dart';
import 'package:eduguard/src/features/sos_system/screens/sos_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const SOSHomePage(),

    Container(
      color: Colors.red,
    ),

    const BlogHome(),
    /*ontainer(
        // Assuming this is a widget class defined in viewblogs.dart
        //color: Colors.green,
        ),*/

    const Questionnairehome(),
    /*Container(
      // Assuming this is a widget class defined in viewblogs.dart
      color: Colors.red,
    ),*/

    Container(
      color: Colors.blue,
    ),

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
    (Container(
      color: Colors.blue,
    )),
    (Container(
      color: Colors.purple,
    )),
  ];
}
