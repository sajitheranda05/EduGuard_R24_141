import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../../../layout.dart';
import '../../../../../common_widgets/Screens/appbar.dart';

class VerifyAge extends StatefulWidget {
  const VerifyAge({super.key});

  @override
  State<VerifyAge> createState() => _VerifyAgeState();
}

class _VerifyAgeState extends State<VerifyAge> {
  File? nicImage;
  File? selfieImage;

  final ImagePicker _picker = ImagePicker();

  // Method to capture or select NIC image
  Future<void> pickNICImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        nicImage = File(pickedFile.path);
      });
    }
  }

  // Method to capture or select Selfie image
  Future<void> pickSelfieImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        selfieImage = File(pickedFile.path);
      });
    }
  }

  // Method to call the age verification API
  Future<void> callAgeVerificationAPI() async {
    if (nicImage != null && selfieImage != null) {
      // Show loading indicator
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );

      var request = http.MultipartRequest(
          'POST', Uri.parse('http://192.168.8.133:5000/ageVerification'));

      request.files
          .add(await http.MultipartFile.fromPath('NIC', nicImage!.path));
      request.files.add(
          await http.MultipartFile.fromPath('selfieImage', selfieImage!.path));

      try {
        /// redirect home
        // Get.offAll(() => const Layout());
        var response = await request.send();
        var responseBody = await http.Response.fromStream(response);
        var jsonResponse = jsonDecode(responseBody.body);

        // Dismiss loader
        Get.back();
        if (response.statusCode == 200) {
          String overallResult = jsonResponse['Overall Result'];

          if (overallResult == 'Pass') {
            // Navigate to the home layout or success page
            Get.offAll(() => const Layout());
          } else {
            // Show error dialog if verification failed
            Get.snackbar(
              'Verification Failed',
              'Please re-check your documents and try again.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
            );
          }
        } else {
          // Handle failure response from API
          Get.snackbar(
            'Error',
            'Failed to verify age. Please try again later.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        // Dismiss loader and handle exception during API call
        Get.back();
        Get.snackbar(
          'Error',
          'An error occurred: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } else {
      // Handle case where both images are not provided
      Get.snackbar(
        'Error',
        'Both NIC and Selfie images are required.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'EduguardLK',
                    style:
                        TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  ),
                  Text('SIGN IN', style: TextStyle(fontSize: 20.0)),
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: pickNICImage,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.greenAccent),
                      ),
                      child: const Center(
                        child: Text(
                          'Capture NIC\nImage',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: pickSelfieImage,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.greenAccent),
                      ),
                      child: const Center(
                        child: Text(
                          'Capture Selfie\nImage',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: callAgeVerificationAPI,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.greenAccent),
                    ),
                    child: const Center(
                      child: Text(
                        'Verify Age',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
