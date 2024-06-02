import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:flutter/material.dart';

class SOSHome extends StatefulWidget {
  const SOSHome({super.key});

  @override
  State<SOSHome> createState() => _SOSHomeState();
}

class _SOSHomeState extends State<SOSHome> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(

      //Custom Appbar
      appBar: CustomAppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, Matteo Perera...', style: TextStyle(fontSize: 14.0, color:Colors.grey),),
            Text('Emergency SOS System.', style: TextStyle(fontSize: 16.0),)
          ],
        ),
      ),

    );
  }
}