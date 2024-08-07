import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:flutter/material.dart';

class SOSEditSettings extends StatelessWidget {
  const SOSEditSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Contact Settings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            const Divider(),
            SizedBox(height: 24.0,),

            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'High Priority Contact',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(height: 2.0,),
                  Text(
                    'This contact will be given the highest priority when using emergency functions.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                  ),
                  SizedBox(height: 24.0,),

                  TextFormField(
                    decoration: const InputDecoration(label: Text('Contact Name')),
                  ),
                  const SizedBox(height: 12.0,),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Contact Number')),
                  ),

                  SizedBox(height: 24.0,),
                  const Divider(),
                  SizedBox(height: 24.0,),

                  Text(
                    'Emergency Contacts',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(height: 2.0,),
                  Text(
                    'This is the section for the contact settings',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                  ),

                  SizedBox(height: 24.0,),


                  //Contact one
                  Text(
                    'Contact One',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(height: 12.0,),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Contact Name')),
                  ),
                  const SizedBox(height: 12.0,),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Contact Number')),
                  ),
                  const SizedBox(height: 24.0,),

                  //Contact Two
                  Text(
                    'Contact Two',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(height: 12.0,),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Contact Name')),
                  ),
                  const SizedBox(height: 12.0,),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Contact Number')),
                  ),
                  const SizedBox(height: 24.0,),

                  //Contact three
                  Text(
                    'Contact Three',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(height: 12.0,),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Contact Name')),
                  ),
                  const SizedBox(height: 12.0,),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Contact Number')),
                  ),
                  const SizedBox(height: 24.0,),

                  //Contact four
                  Text(
                    'Contact Four',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(height: 12.0,),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Contact Name')),
                  ),
                  const SizedBox(height: 12.0,),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Contact Number')),
                  ),
                  const SizedBox(height: 24.0,),


                ],
              ),
            ),

            SizedBox(height: 24.0,),
            const Divider(),
            SizedBox(height: 24.0,),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //Get.to(() => const UserSignUp());
                },
                child: const Text('Save Settings'),
              ),
            ),

            SizedBox(height: 24.0,),


          ],
        ),
      ),
    );
  }
}
