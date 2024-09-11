import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/std_detection/models/specialist_model.dart';
import 'package:eduguard/src/features/std_detection/wigets/clinic_card.dart';
import 'package:eduguard/src/features/std_detection/wigets/qualification_card.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class SpecialistView extends StatelessWidget {
  const SpecialistView({super.key, required this.specialist});

  final SpecialistModel specialist;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(
          title: Text(
            'Dr. Loremi Dolor',
            style: TextStyle(fontSize: 18.0),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.specialist1,
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Contact Information',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 14,
                                                  color: Color(0xff1e2425),
                                                  fontFamily: 'Poppins-Medium',
                                                  fontWeight:
                                                      FontWeight.normal),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.phone_in_talk,
                                                  color: Color(0xFF37BE9E),
                                                  size: 20.0,
                                                ),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      '0112233445',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xff9fa2a2),
                                                          fontFamily:
                                                              'Poppins-Regular',
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.mail,
                                                  color: Color(0xFF37BE9E),
                                                  size: 18.0,
                                                ),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      'loremipsumi@gmail.com',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xff9fa2a2),
                                                          fontFamily:
                                                              'Poppins-Regular',
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Color(0xFF37BE9E),
                                                  size: 20.0,
                                                ),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      'lorem ipsum city',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xff9fa2a2),
                                                          fontFamily:
                                                              'Poppins-Regular',
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 321,
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
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Lorem ipsum dolor sit amet consectetur. Laoreet sed sit feugiat ac tincidunt vitae. At tellus lectus donec et nulla risus fames quam faucibus. Habitant aliquam arcu nec in lectus risus. Vestibulum venenatis amet sed vel lobortis eu sed at. Elementum magnis ullamcorper magna id natoque quis. Diam odio elit vel pellentesque nec volutpat dui. Non sit est et vestibulum et. ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          color: Color(0xff9fa2a2),
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.normal),
                                      maxLines: 50,
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
                                  'Clinics Availability',
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
                              ListView.builder(
                                itemCount: 3,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) => const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10.0), // Space between items
                                  child: ClinicCard(), // List item widget
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
                                  'Qualifications',
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
                              ListView.builder(
                                itemCount: 2,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) => const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10.0), // Space between items
                                  child:
                                      QualificationCard(), // List item widget
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
