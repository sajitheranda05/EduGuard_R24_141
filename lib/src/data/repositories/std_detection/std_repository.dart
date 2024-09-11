import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/std_detection/dummy_std_data.dart';
import 'package:eduguard/src/features/std_detection/models/std_model.dart';
import 'package:eduguard/src/features/std_detection/models/symptom_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class STDRepository extends GetxController {
  static STDRepository get instance => Get.find();

  ///Firestore instance for database interactions
  final _db = FirebaseFirestore.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///Get all stds
  Future<List<STDModel>> getAllSTDs() async {
    try {
      final snapshot = await _db.collection('STDs').get();
      return snapshot.docs.map((e) => STDModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw ('Firebase Exception : $e');
    } on PlatformException catch (e) {
      throw ('Platform Exception : $e');
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// Upload dummy data to the Cloud Firebase
  Future<void> addDummySTDs() async {
    // Dummy data for STDs
    final dummySTDs = DummySTDs.data;

    try {
      // Loop through each dummy STD and add it to Firestore
      for (var data in dummySTDs) {
        // Upload image and get the URL
        String? imageUrl;
        if (data.stdImg.isNotEmpty) {
          imageUrl = await uploadImage(data.stdImg);
        }

        ///  // Upload symptom images and update symptom list
        ///  final updatedSymptoms = <SymptomModel>[];
        ///   for (var symptom in data.stdSymptoms ?? []) {
        ///    String? symptomImageUrl;
        ///    if (symptom.symptomImg.isNotEmpty) {
        ///      symptomImageUrl = await uploadImage(
        ///          symptom.symptomImg); // **Handle symptom image upload**
        ///    }

        ///    updatedSymptoms.add(SymptomModel(
        ///      symptomId: symptom.symptomId,
        ///      symptomName: symptom.symptomName,
        ///      symptomDescription: symptom.symptomDescription,
        ///      symptomImg: symptomImageUrl ?? symptom.symptomImg,
        ///    ));
        ///  }

        // Prepare the data to be added to Firestore
        final dataToAdd = {
          'STD_img': imageUrl ?? data.stdImg,
          'STD_name': data.stdName,
          'STD_description': data.stdDescription,
          'isCommon': data.isCommon,
          'STD_symptoms': data.stdSymptoms,
          'STD_prevention': data.stdPrevention,
          'STD_transmission': data.stdTransmission,

          ///'STD_symptoms': updatedSymptoms
          ///     .map((e) => e.toJson())
          ///     .toList(), // **Update with symptom data**
        };

        // Add data to Firestore
        await _firestore.collection('STDs').add(dataToAdd);
        print('Added: ${data.stdName}');
      }

      print("All dummy STDs added successfully!");
    } catch (e) {
      print("Error adding dummy STDs: $e");
    }
  }

  Future<String?> uploadImage(String assetPath) async {
    try {
      // Load the image from assets
      final ByteData bytes = await rootBundle.load(assetPath);
      final Uint8List imageData = bytes.buffer.asUint8List();

      // Create a reference to Firebase Storage
      final fileName = assetPath.split('/').last;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/std_detection/$fileName');

      // Upload the image
      final uploadTask = storageRef.putData(imageData);

      // Wait for the upload to complete
      await uploadTask.whenComplete(() {});

      // Get the download URL
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
