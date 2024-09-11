import 'package:eduguard/src/features/authentication/user/register/models/user_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/features/authentication/user/register/screens/email_verification.dart';
import 'package:eduguard/src/utils/popups/full_screen_loader.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/role_enum.dart';

class StudentSignUpController extends GetxController {
  // Form Field Controllers
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final age = TextEditingController();
  final contactNumber = TextEditingController();
  final password = TextEditingController();
  final emergencyContacts = TextEditingController();

  // Reactive variables for dropdowns
  final selectedGender = 'Male'.obs; // Default value set to 'Male'
  final selectedMaritalStatus = 'Single'.obs; // Default value set to 'Single'

  // Reactive password visibility and terms acceptance
  final hidePassword = true.obs;
  final termsCheck = false.obs;

  // Form Key
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Firebase Authentication and Firestore references
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Signup method
  Future<void> signup() async {
    try {
      // Start the loader while processing
      AppFullScreenLoader.openLoadingDialog('Processing your information...');

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      // Check if terms and conditions are accepted
      if (!termsCheck.value) {
        AppFullScreenLoader.stopLoading();
        AppSnackBars.warningSnackBar(
          title: 'Terms & Conditions',
          message: 'You must accept the terms and conditions to create an account.',
        );
        return;
      }

      // Register user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // Create a new Student model
      UserModel newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        age: age.text.trim(),
        email: email.text.trim(),
        contactNumber: contactNumber.text.trim(),
        profilePicture: '',
        role: Role.student,
      );

      // Save the student data to Firestore
      await _firestore.collection('Users').doc(newUser.id).set(newUser.toJson());

      // Stop the loader
      AppFullScreenLoader.stopLoading();

      // Show success message
      AppSnackBars.successSnackBar(
        title: 'Account Created',
        message: 'Your account has been successfully created! Please verify your email to continue.',
      );

      // save role into shared preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('role', Role.student.toString());

      // Navigate to email verification screen
      Get.to(() => EmailVerification(email: email.text.trim()));
    } catch (e) {
      // Handle errors
      AppFullScreenLoader.stopLoading();
      AppSnackBars.errorSnackBar(
        title: 'Signup Failed',
        message: e.toString(),
      );
    }
  }

  @override
  void dispose() {
    email.dispose();
    firstName.dispose();
    lastName.dispose();
    age.dispose();
    contactNumber.dispose();
    password.dispose();
    emergencyContacts.dispose();
    super.dispose();
  }
}
