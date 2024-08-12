import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/personalization/controllers/update_name_controller.dart';
import 'package:eduguard/src/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final updateNameController =Get.put(UpdateNameController());
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Change Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            const SizedBox(height: 2.0,),
            Text(
              'Use real name for easy verification. This name will appear on several pages.',
              style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
            ),
            const Divider(),

            const SizedBox(height: 24.0,),


            Form(
                key: updateNameController.updateNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: updateNameController.firstName,
                      validator: (value) => AppValidations.validateEmptyText('First name', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      controller: updateNameController.lastName,
                      validator: (value) => AppValidations.validateEmptyText('Last name', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                    ),
                  ],
                )
            ),

            const SizedBox(height: 24.0,),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  updateNameController.updateUserName();
                },
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );

  }
}