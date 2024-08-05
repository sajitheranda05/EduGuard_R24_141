import 'dart:async';

import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/authentication/user/register/screens/verification_success.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  //send email whenever verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  //Send email verification
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerifcation();
      AppSnackBars.successSnackBar(title: 'Email Sent', message: 'Please check your inbox and verify your email.');
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //timer to verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user =FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => const SuccessScreen());
      }
    }
    );
  }

  //Manually check if email verified
  checkEmailVerification() async {
    final currentUser =FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => const SuccessScreen());
    }
  }

}