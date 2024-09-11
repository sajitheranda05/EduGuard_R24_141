import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/data/repositories/user_repository.dart';
import 'package:eduguard/src/features/authentication/user/register/models/user_model.dart';
import 'package:eduguard/src/features/authentication/user/register/screens/email_verification.dart';
import 'package:eduguard/src/utils/network_manager.dart';
import 'package:eduguard/src/utils/popups/full_screen_loader.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/role_enum.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final age = TextEditingController();
  final contactNumber = TextEditingController();
  final password = TextEditingController();
  final emergencyContacts = TextEditingController();

  final hidePassword =true.obs;
  final termsCheck =false.obs;

  GlobalKey<FormState> signupFormKey =GlobalKey<FormState>();

  void signup() async {
    try{
      //Start Loader
      AppFullScreenLoader.openLoadingDialog('We are processing your information...');

      //check network connectivity
      final isConnected =await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      //Form validation
      if (!signupFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      //Terms and Conditions Check
      if(!termsCheck.value) {
        AppSnackBars.warningSnackBar(
            title: 'Accept privacy policy',
            message: 'In order to create account, you must have to read and accept the Privacy policy & Terms of use'
        );
        return;
      }

      //register user in the firebase authentication & save user data in the firebase
      final userCredential =await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Save authenticate user data in the firebase firestore
      final newUser =UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        age: age.text.trim(),
        email: email.text.trim(),
        contactNumber: contactNumber.text.trim(),
        profilePicture: '',
        role: Role.user,
      );

      final userRepository =Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);


      AppFullScreenLoader.stopLoading();

      AppSnackBars.successSnackBar(title: 'Congratulations', message: 'Your account has been created! verify email to continue.');

      // save role into shared preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('role', Role.user.toString());

      Get.to(() => EmailVerification(email: email.text.trim(),));

    } catch (error) {
      AppSnackBars.errorSnackBar(title: 'Oh snap!', message: error.toString());
    }

  }
}