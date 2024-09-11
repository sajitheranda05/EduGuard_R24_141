import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/std_detection/models/std_model.dart';
import 'package:eduguard/src/features/std_detection/wigets/symptom_card.dart';
import 'package:flutter/material.dart';

class STDView extends StatelessWidget {
  const STDView({super.key, required this.std});

  final STDModel std;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            std.stdName,
            style: const TextStyle(fontSize: 18.0),
          ),
          showBackArrow: true, // Show the back arrow
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xfff6faf9),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 2 / 1, // 2:1 ratio
                                  child: Image.network(
                                    std.stdImg,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                // const Row(
                                // children: [
                                //  Expanded(
                                //  child: Text(
                                //    'Microscopic view of Lorem Ipsum',
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //      decoration: TextDecoration.none,
                                //      fontSize: 10,
                                //     color: Color(0xff9fa2a2),
                                //     fontFamily: 'Poppins-Regular',
                                //     fontWeight: FontWeight.normal),
                                // maxLines: 2,
                                //  overflow: TextOverflow.ellipsis,
                                // ),
                                // ),
                                //  ],
                                //  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                child: Text(
                                  'About',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      color: Color(0xff1e2425),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      std.stdDescription,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          color: Color(0xff9fa2a2),
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.normal),
                                      maxLines: 100,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                child: Text(
                                  'Symptoms',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      color: Color(0xff1e2425),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                // width: 321,
                                child: Text(
                                  std.stdSymptoms,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
                                    color: Color(0xff9fa2a2),
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: 100,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              ///  ListView.builder(
                              ///  itemCount: std.stdSymptoms?.length ?? 0,
                              ///  shrinkWrap: true,
                              ///  physics: const NeverScrollableScrollPhysics(),
                              ///  itemBuilder: (_, index) => const Padding(
                              ///   padding: EdgeInsets.only(
                              ///       bottom: 10.0), // Space between items
                              ///   child: SymptomCard(), // List item widget
                              ///  ),
                              ///),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                // width: 321,
                                child: Text(
                                  'Transmission',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      color: Color(0xff1e2425),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                // width: 321,
                                child: Text(
                                  std.stdTransmission,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
                                    color: Color(0xff9fa2a2),
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: 100,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                child: Text(
                                  'Prevention Methods',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      color: Color(0xff1e2425),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                // width: 321,
                                child: Text(
                                  std.stdPrevention,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
                                    color: Color(0xff9fa2a2),
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: 100,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    /*Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Learn more about this STD',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 12,
                                              color: Color(0xff1e2425),
                                              fontFamily: 'Poppins-Regular',
                                              fontWeight: FontWeight.normal),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'https://en.wikipedia.org/wiki/Syphilis',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 12,
                                              color: Color(0xff9fa2a3),
                                              fontFamily: 'Poppins-Regular',
                                              fontWeight: FontWeight.normal),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),*/
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
