import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFullScreenLoader {
  static void openLoadingDialog(String text) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: Colors.black,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250),
                  const CircularProgressIndicator(color: Colors.white,),
                  const SizedBox(height: 45.0,),
                  Text(text, style: const TextStyle(fontSize: 24.0, color: Colors.white),)
                ],
              ),

            )
        )
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }

}