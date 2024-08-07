import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/sos_system/screens/sos_edit_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SOSSettings extends StatelessWidget {
  const SOSSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                const SizedBox(height: 2.0,),
                Text(
                  'This is the section for the contact settings',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                ),
                const Divider(),

                const SizedBox(height: 24.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'High Priority Contact',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    IconButton(onPressed: () {
                      Get.to(() => const SOSEditSettings());
                    }, icon: const Icon(Icons.keyboard_arrow_right_rounded))
                  ],
                ),
                Text(
                  'This contact will be given the highest priority when using emergency functions.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                ),


                const SizedBox(height: 24.0,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Contact One', style: TextStyle(fontSize: 16.0),),
                    Text('0705248793', style: TextStyle(fontSize: 16.0),),
                  ],
                ),
                const SizedBox(height: 12.0,),
                const Divider(),
                const SizedBox(height: 24.0,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Emergency Contacts',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    IconButton(onPressed: () {
                      Get.to(() => const SOSEditSettings());
                    }, icon: const Icon(Icons.keyboard_arrow_right_rounded))
                  ],
                ),
                Text(
                  'This contact will be given the highest priority when using emergency functions.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                ),

                const SizedBox(height: 24.0,),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Contact One', style: TextStyle(fontSize: 16.0),),
                    Text('0705248793', style: TextStyle(fontSize: 16.0),),
                  ],
                ),
                const SizedBox(height: 12.0,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Contact two', style: TextStyle(fontSize: 16.0),),
                    Text('0705248793', style: TextStyle(fontSize: 16.0),),
                  ],
                ),
                const SizedBox(height: 12.0,),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Contact three', style: TextStyle(fontSize: 16.0),),
                    Text('0705248793', style: TextStyle(fontSize: 16.0),),
                  ],
                ),
                const SizedBox(height: 12.0,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Contact four', style: TextStyle(fontSize: 16.0),),
                    Text('0705248793', style: TextStyle(fontSize: 16.0),),
                  ],
                ),
                const SizedBox(height: 12.0,),

                const Divider(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
