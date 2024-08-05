import 'package:eduguard/src/features/authentication/user/login/controllers/forget_password_controller.dart';
import 'package:eduguard/src/features/authentication/user/login/screens/user_login.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:eduguard/src/utils/constants/text_strings.dart';
import 'package:eduguard/src/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword ({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [

                Image(
                  image: const AssetImage(AppImages.resetPassword),
                  alignment: Alignment.center,
                  width: AppHelperFunctions.screenWidth() *0.6,
                ),
                const SizedBox(height: 24.0),

                Text(email, style:const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                const SizedBox(height: 24),
                const Text(AppText.reset_password_title, style:TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
                const SizedBox(height: 12),
                const Text(AppText.reset_password_desc, style:TextStyle(fontSize: 14.0), textAlign: TextAlign.center,),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => const UserLogin());
                    },
                    child: const Text('Done'),
                  ),
                ),

                const SizedBox(height: 8.0,),

                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      ForgetPasswordController.instance.resendPasswordResetEmail(email);
                    },
                    child: const Text('Resend Email'),
                  ),
                ),


              ],
            )
        ),
      ),
    );
  }
}
