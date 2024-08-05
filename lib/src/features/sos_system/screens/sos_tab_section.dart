import 'package:eduguard/src/features/sos_system/screens/sos_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SOSTabScreen extends StatelessWidget {
  const SOSTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 350,
              height: 350,
              alignment: Alignment.center,
              // Central SOS button
              child:ElevatedButton(
                onPressed: () {
                  // Add your SOS button functionality here
                  Get.to(() => const SOSStateScreen());
                  print('SOS Button Pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(96.0),
                ),
                child: const Icon(Icons.sos_outlined, size: 64.0, color: Colors.white,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
