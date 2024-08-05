import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/authentication/user/register/controllers/email_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({this.email, super.key});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final emailVerificationController =Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.offAll(() => AuthenticationRepository.instance.logout()) , icon: const Icon(Icons.close))
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Verify Your Email Address', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),),
              const SizedBox(height: 12.0,),
              Text(email ?? '', style: const TextStyle(fontSize: 16.0), textAlign: TextAlign.start,),
              const SizedBox(height: 12.0,),
              const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel urna felis.Nulla ac elit in ex condimentum condimentum finibus sed nunc.', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),),
              const SizedBox(height: 24.0,),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    emailVerificationController.checkEmailVerification();
                  },
                  child: const Text('Continue'),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    emailVerificationController.sendEmailVerification();
                  },
                  child: const Text('Resend Email'),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    //emailVerificationController.sendEmailVerification();
                    AuthenticationRepository.instance.logout();
                  },
                  child: const Text('logout'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
