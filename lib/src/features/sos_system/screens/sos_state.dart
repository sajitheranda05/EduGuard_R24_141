import 'package:eduguard/src/features/sos_system/controllers/sos_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SOSStateScreen extends StatelessWidget {
  const SOSStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sosStateController =Get.put(SOSStateController());
    
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_rounded, color:Colors.red, size: 100.0,),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  sosStateController.toggleSOS();
                  Get.back();
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Deactivate SOS'),
            ),
            
          ],
        ),
      ),
    );
  }
}
