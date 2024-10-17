import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/features/questionnaire/model/questionnaremodel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QuestionnaireRepository extends GetxService {
  static QuestionnaireRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save qs data to Firestore
  Future<void> saveQsRecord(Map<String, dynamic> qsData) async {
    try {
      await _db.collection('Questionnaire').add(qsData); // Auto-generates an ID
    } on FirebaseException catch (e) {
      throw ('Firebase Exception: $e');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Fetch qs details by QS ID
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchQsDetails(
      String qsId) async {
    try {
      return await _db.collection('Questionnaire').doc(qsId).get();
    } on FirebaseException catch (e) {
      throw ('Firebase Exception: $e');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Update qs details by QS ID
  Future<void> updateQsDetails(String qsId, Map<String, dynamic> qsData) async {
    try {
      await _db.collection('Questionnaire').doc(qsId).update(qsData);
    } on FirebaseException catch (e) {
      throw ('Firebase Exception: $e');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Update a single field of the qs by qs ID
  Future<void> updateSingleQsField(
      String qsId, Map<String, dynamic> updatedField) async {
    try {
      await _db.collection('QS').doc(qsId).update(updatedField);
    } on FirebaseException catch (e) {
      throw ('Firebase Exception: $e');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Remove QS data by qs ID
  Future<void> removeQsDetails(String qsId) async {
    try {
      await _db.collection('QS').doc(qsId).delete();
    } on FirebaseException catch (e) {
      throw ('Firebase Exception: $e');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  //Get all QS
  Future<List<Questionnaremodel>> getallQs({required int limit}) async {
    try {
      final snapshot = await _db.collection('Questionnaire').get();
      return snapshot.docs
          .map((e) => Questionnaremodel.fromSnapshot(e))
          .toList();
    } on FirebaseException catch (e) {
      throw ('Firebase Exception : $e');
    } on PlatformException catch (e) {
      throw ('Platform Exception : $e');
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
