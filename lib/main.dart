// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:eduguard/src/features/onboarding/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EduguardLK",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: OnboardingScreen(),
      );
  }
}

