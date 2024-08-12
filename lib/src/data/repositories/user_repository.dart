import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/authentication/user/register/models/user_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db =FirebaseFirestore.instance;

  //save userdata to firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
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

  //Fetch user details
  Future<UserModel> fetchUserDetails() async{
    try {
      final documentSnapshot =await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      }else {
        return UserModel.empty();
      }
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

  //Update user data
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection('Users').doc(updatedUser.id).update(updatedUser.toJson());
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

  //update a single field
  Future<void> updateSingleField(Map<String,dynamic> json) async {
    try {
      await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).update(json);
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

  //remove user Data
  Future<void> removeUserDetails(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
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