import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationDrawerController extends GetxController {
  var scaffoldKey =GlobalKey<ScaffoldState>();

  void openNavigationDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeNavigationDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }
}