import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/authentication/user/login/controllers/forget_password_controller.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:eduguard/src/utils/constants/text_strings.dart';
import 'package:eduguard/src/utils/helper_functions.dart';
import 'package:eduguard/src/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {

    final forgetPasswordController =Get.put(ForgetPasswordController());

    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Image(
                  image: const AssetImage(AppImages.forgotPassword),
                  alignment: Alignment.center,
                  width: AppHelperFunctions.screenWidth() * 0.6,
                ),
              ),

              const SizedBox(height: 32.0),

              const Text(AppText.forgot_password_title, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
              const SizedBox(height: 12.0,),
              const Text(AppText.forgot_password_desc, style: TextStyle(fontSize: 14.0),),
              const SizedBox(height: 12.0,),

              Form(
                key: forgetPasswordController.forgetPasswordFormKey,
                child: TextFormField(
                  controller: forgetPasswordController.email,
                  validator: (value) => AppValidations.validateEmail(value),
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ),
              const SizedBox(height: 24.0,),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => forgetPasswordController.sendPasswordResetEmail(),
                  child: const Text('Submit'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
