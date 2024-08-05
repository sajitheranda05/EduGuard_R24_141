import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/authentication/user/login/screens/user_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: () => Get.offAll(() => const UserLogin()) , icon: const Icon(Icons.close))
          ],
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24.0,),
                const Text('Email Verified Successfully...', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),),
                const SizedBox(height: 12.0,),
                const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel urna felis.Nulla ac elit in ex condimentum condimentum finibus sed nunc.', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),),
                const SizedBox(height: 24.0,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      AuthenticationRepository.instance.screenRedirect();
                    },
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
