import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/common_widgets/Screens/tabbar.dart';
import 'package:eduguard/src/features/sos_system/screens/sos_state.dart';
import 'package:eduguard/src/features/sos_system/screens/sos_tab_section.dart';
import 'package:flutter/material.dart';

class SOSHomePage extends StatefulWidget {
  const SOSHomePage({super.key});

  @override
  State<SOSHomePage> createState() => _SOSHomePageState();
}

class _SOSHomePageState extends State<SOSHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(

          appBar: const CustomAppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello, Matteo Perera...', style: TextStyle(fontSize: 14.0, color:Colors.grey),),
                Text('Emergency SOS System.', style: TextStyle(fontSize: 16.0),)
              ],
            ),
          ),

          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const CustomTabBar(
                  tabs: [
                    Tab(child: Text('SOS'),),
                    Tab(child: Text('Chat'),),
                    Tab(child: Text('Location'),),
                  ],
                ),
              ),
              const Expanded(
                  child: TabBarView(
                    children: [
                      Center(
                        child: SOSTabScreen(),
                      ),
                      Center(
                        child: Text('Content for Chat system'),
                      ),
                      Center(
                        child: Text('Content for Location system'),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
    );
  }
}
