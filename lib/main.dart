// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:eduguard/src/features/sos_system/screens/sos_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EduguardLK",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MyHomePage(),
      );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   int currentPageIndex =0;

  //Call page function
   List<Widget> featureHomePages =[
    SOSHome(),//Text('Home', style:TextStyle(fontSize: 20.0)),
    Text('Education', style:TextStyle(fontSize: 20.0)),
    Text('Blogs', style:TextStyle(fontSize: 20.0)),
    Text('Questionnare', style:TextStyle(fontSize: 20.0)),
    Text('Health', style:TextStyle(fontSize: 20.0)),
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: AppBar(
        backgroundColor: Colors.teal[50],
        title: const Text("EduguardLK"),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.verified_user)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app))
        ],
      ),

      body: IndexedStack(
        index: currentPageIndex,
        children: featureHomePages,
      ),

      //Bottom Navibagtion
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        height: 80.0,
        backgroundColor: Colors.teal[50],
        indicatorColor: Colors.teal[300],
        destinations: <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.book), label: 'Education'),
          NavigationDestination(icon: Icon(Icons.home), label: 'Blogs'),
          NavigationDestination(icon: Icon(Icons.home), label: 'Questionnare'),
          NavigationDestination(icon: Icon(Icons.home), label: 'Health'),
        ],
      )
    );
  }
}

