import 'package:eduguard/layout.dart';
import 'package:eduguard/src/data/repositories/user_repository.dart';
import 'package:eduguard/src/features/authentication/user/login/screens/user_login.dart';
import 'package:eduguard/src/features/authentication/user/register/models/role_enum.dart';
import 'package:eduguard/src/features/authentication/user/register/screens/email_verification.dart';
import 'package:eduguard/src/features/onboarding/screens/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/authentication/user/login/screens/verify_age.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get  instance => Get.find();

  final deviceStorage =GetStorage();
  final _auth =FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  //Get authenticated user data
  User? get authUser => _auth.currentUser;

  //First time onboarding
  screenRedirect() async {
    final user =_auth.currentUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role')?.split('.').last;
    if (user != null) {
      if (user.emailVerified && role.toString().toUpperCase() == "STUDENT") {
        Get.offAll(() => const Layout());
      }else if (user.emailVerified && role.toString().toUpperCase() ==  "USER"){
        Get.offAll(() => const VerifyAge());
      }else{
        Get.offAll(() => EmailVerification(email: _auth.currentUser?.email,));
      }
    } else {
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const UserLogin())
          : Get.offAll(() => const OnboardingScreen());
    }

  }

  //Email Authentication-Login
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      throw('Firebase auth Exception : $e');
    }on FirebaseException catch (e) {
      throw('Firebase Exception : $e');
    }on FormatException catch (e) {
      throw('Format Exception : $e');
    }on PlatformException catch (e) {
      throw('Platform Exception : $e');
    }catch (e){
      throw 'Something went wrong, Please try again';
    }
  }

  //Email authentication-Register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      throw('Firebase auth Exception : $e');
    }on FirebaseException catch (e) {
      throw('Firebase Exception : $e');
    }on FormatException catch (e) {
      throw('Format Exception : $e');
    }on PlatformException catch (e) {
      throw('Platform Exception : $e');
    }catch (e){
      throw 'Something went wrong, Please try again';
    }
  }

  //Email Authentication-Verify Email
  Future<void> sendEmailVerifcation() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e){
      throw('Firebase auth Exception : $e');
    }on FirebaseException catch (e) {
      throw('Firebase Exception : $e');
    }on FormatException catch (e) {
      throw('Format Exception : $e');
    }on PlatformException catch (e) {
      throw('Platform Exception : $e');
    }catch (e){
      throw 'Something went wrong, Please try again';
    }
  }

  //Email authentication-Forgot Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e){
      throw('Firebase auth Exception : $e');
    }on FirebaseException catch (e) {
      throw('Firebase Exception : $e');
    }on FormatException catch (e) {
      throw('Format Exception : $e');
    }on PlatformException catch (e) {
      throw('Platform Exception : $e');
    }catch (e){
      throw 'Something went wrong, Please try again';
    }
  }

  //LogoutUser
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const UserLogin());
    }on FirebaseAuthException catch (e){
      throw('Firebase auth Exception : $e');
    }on FirebaseException catch (e) {
      throw('Firebase Exception : $e');
    }on FormatException catch (e) {
      throw('Format Exception : $e');
    }on PlatformException catch (e) {
      throw('Platform Exception : $e');
    }catch (e){
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> reAuthenticateEmailandPassword(String email, String password) async {
    try {
      AuthCredential credential =EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    }on FirebaseAuthException catch (e){
      throw('Firebase auth Exception : $e');
    }on FirebaseException catch (e) {
      throw('Firebase Exception : $e');
    }on FormatException catch (e) {
      throw('Format Exception : $e');
    }on PlatformException catch (e) {
      throw('Platform Exception : $e');
    }catch (e){
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserDetails(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    }on FirebaseAuthException catch (e){
      throw('Firebase auth Exception : $e');
    }on FirebaseException catch (e) {
      throw('Firebase Exception : $e');
    }on FormatException catch (e) {
      throw('Format Exception : $e');
    }on PlatformException catch (e) {
      throw('Platform Exception : $e');
    }catch (e){
      throw 'Something went wrong, Please try again';
    }
  }



}