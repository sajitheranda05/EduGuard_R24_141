// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SOSHome extends StatefulWidget {
  const SOSHome({super.key});

  @override
  State<SOSHome> createState() => _SOSHomeState();
}

class _SOSHomeState extends State<SOSHome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Text('Emergency SOS System', style: TextStyle(fontSize: 20.0),),
    );
  }
}