import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/blogs/Screen/comments.dart';
import 'package:eduguard/src/features/questionnaire/model/questionnaremodel.dart';
import 'package:eduguard/src/features/questionnaire/screens/editquestionnire.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class QuestionnaireView extends StatelessWidget {
  const QuestionnaireView({super.key, required this.qs1});
  final Questionnaremodel qs1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Questionnaire View.',
                style: TextStyle(fontSize: 16.0),
              )
            ],
          ),
          showBackArrow: true, // Show the back arrow
        ),
        body: Container(
          color: Colors.white,
          child: Container(
            width: 360,
            height: 712,
            decoration: const BoxDecoration(
              color: Color(0xfff5f9f8),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  width: 360,
                  top: 0,
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
                                child: Text(
                                  qs1.QsName,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      color: Color(0xff1e2425),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: const Text(
                                  'Understanding the Basics of \nSexual Health: A Guide to Wellness',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      color: Color(0xff000000),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Image.network(
                                  qs1.QSImage,
                                  height: 243,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Text(
                                  qs1.Qs,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      color: Color(0xff000000),
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 9999,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const Comments());
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff0c6170),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Comments',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 12,
                                                  color: Color(0xffffffff),
                                                  fontFamily: 'Poppins-Medium',
                                                  fontWeight:
                                                      FontWeight.normal),
                                              maxLines: 9999,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 111),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(EditQuestionnaire());
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff37be9d),
                                            width: 1),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Edit',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 12,
                                                  color: Color(0xff37be9d),
                                                  fontFamily: 'Poppins-Medium',
                                                  fontWeight:
                                                      FontWeight.normal),
                                              maxLines: 9999,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
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
        ),
      ),
    );
  }
}
