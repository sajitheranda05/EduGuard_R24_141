import 'package:get/get.dart';

class SOSStateController extends GetxController {
  final isSOSActive =false.obs;

  void toggleSOS() {
    isSOSActive.value =!isSOSActive.value;
  }
}