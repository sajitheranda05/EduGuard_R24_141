import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/utils/network_manager.dart';
import 'package:eduguard/src/utils/popups/full_screen_loader.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignInController extends GetxController {
  final rememberMe =false.obs;
  final hidePassword =true.obs;
  final localStorage =GetStorage();
  final email =TextEditingController();
  final password =TextEditingController();
  GlobalKey<FormState> loginFormKey =GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    final storedEmail = localStorage.read('REMEMBER_ME_EMAIL');
    final storedPassword = localStorage.read('REMEMBER_ME_PASSWORD');

    // Check if the email and password are not null or empty
    if (storedEmail != null && storedEmail.isNotEmpty) {
      email.text = storedEmail;
    }

    if (storedPassword != null && storedPassword.isNotEmpty) {
      password.text = storedPassword;
    }
  }

  Future<void> emailandPasswordSignIn() async {
    try {
      AppFullScreenLoader.openLoadingDialog('Logging you in');

      //check network connectivity
      final isConnected =await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final userCredentials =await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      AppFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();

    } catch (error) {
      AppFullScreenLoader.stopLoading();
      AppSnackBars.errorSnackBar(title: 'Oh snap!', message: error.toString());
    }
  }

}