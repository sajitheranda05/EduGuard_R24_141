import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/authentication/user/login/screens/reset_password.dart';
import 'package:eduguard/src/utils/network_manager.dart';
import 'package:eduguard/src/utils/popups/full_screen_loader.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email =TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey =GlobalKey<FormState>();

  sendPasswordResetEmail() async {
    try {
      AppFullScreenLoader.openLoadingDialog('Processing your request...');

      //check network connectivity
      final isConnected =await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      if (!forgetPasswordFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      AppFullScreenLoader.stopLoading();
      AppSnackBars.successSnackBar(title: 'Email sent', message: 'Email link sent to reset your password'.tr);

      Get.to(() => ResetPassword(email: email.text.trim()));

    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppSnackBars.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {

  }

}