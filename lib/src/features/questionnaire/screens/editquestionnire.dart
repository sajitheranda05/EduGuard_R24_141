import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/blogs/Screen/blogpostview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditQuestionnaire extends StatefulWidget {
  EditQuestionnaire({super.key});

  @override
  State<StatefulWidget> createState() => _EditQuestionnaire();
}

class _EditQuestionnaire extends State<EditQuestionnaire> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Questionnaire',
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
            height: 619,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      const Text(
                                                                    'Blog Title',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .none,
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff000000),
                                                                        fontFamily:
                                                                            'Poppins-Regular',
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                    maxLines:
                                                                        9999,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 43,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0xffffffff),
                                                                    border: Border.all(
                                                                        color: const Color(
                                                                            0xffe8e8e8),
                                                                        width:
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40),
                                                                  ),
                                                                  child:
                                                                      const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            15,
                                                                        top: 10,
                                                                        right:
                                                                            15,
                                                                        bottom:
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Lorem ipsum dolor sit',
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: Color(0xff9fa2a2), fontFamily: 'Poppins-Regular', fontWeight: FontWeight.normal),
                                                                              maxLines: 9999,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                145),
                                                                      ],
                                                                    ),
                                                                  ),
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
                                              const SizedBox(height: 30),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      const Text(
                                                                    'Blog Content',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .none,
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff000000),
                                                                        fontFamily:
                                                                            'Poppins-Regular',
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                    maxLines:
                                                                        9999,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0xffffffff),
                                                                    border: Border.all(
                                                                        color: const Color(
                                                                            0xffe8e8e8),
                                                                        width:
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            15,
                                                                        top: 10,
                                                                        right:
                                                                            15,
                                                                        bottom:
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Container(
                                                                                    width: double.infinity,
                                                                                    child: const Text(
                                                                                      'Lorem ipsum dolor sit amet consectetur. \nFaucibus consequat ultrices sit fermentum \nut ipsum aliquet senectus sagittis. \nQuis consectetur etiam vitae semper eu \nplacerat dolor.',
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: Color(0xff9fa2a2), fontFamily: 'Poppins-Regular', fontWeight: FontWeight.normal),
                                                                                      maxLines: 9999,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                145),
                                                                      ],
                                                                    ),
                                                                  ),
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
                                              const SizedBox(height: 30),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Blog Based Image',
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration
                                                                                .none,
                                                                            fontSize:
                                                                                12,
                                                                            color: Color(
                                                                                0xff000000),
                                                                            fontFamily:
                                                                                'Poppins-Regular',
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                        maxLines:
                                                                            9999,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              105),
                                                                      Icon(
                                                                        Icons
                                                                            .upload,
                                                                        color: Color(
                                                                            0xFFBFC5C6),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 80,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0xffffffff),
                                                                    border: Border.all(
                                                                        color: const Color(
                                                                            0xffe8e8e8),
                                                                        width:
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          'images/image_I702364914611008.png',
                                                                          width:
                                                                              20,
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                10),
                                                                        const Text(
                                                                          'Edit  an Image',
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style: TextStyle(
                                                                              decoration: TextDecoration.none,
                                                                              fontSize: 12,
                                                                              color: Color(0xff9fa2a2),
                                                                              fontFamily: 'Poppins-Regular',
                                                                              fontWeight: FontWeight.normal),
                                                                          maxLines:
                                                                              9999,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
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
                                              const SizedBox(height: 30),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      const Text(
                                                                    'Blogger Name',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .none,
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff000000),
                                                                        fontFamily:
                                                                            'Poppins-Regular',
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                    maxLines:
                                                                        9999,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0xffffffff),
                                                                    border: Border.all(
                                                                        color: const Color(
                                                                            0xffe8e8e8),
                                                                        width:
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40),
                                                                  ),
                                                                  child:
                                                                      const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            15,
                                                                        top: 10,
                                                                        right:
                                                                            15,
                                                                        bottom:
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Lorem ipsum dolor sit',
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: Color(0xff9fa2a2), fontFamily: 'Poppins-Regular', fontWeight: FontWeight.normal),
                                                                              maxLines: 9999,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                145),
                                                                      ],
                                                                    ),
                                                                  ),
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xff37be9d),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Clear',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xff37be9d),
                                                            fontFamily:
                                                                'Poppins-Medium',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        maxLines: 9999,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 76),
                                              GestureDetector(
                                                onTap: () {
                                                  //Get.to(const BlogPostView(blog1: b,));
                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff0c6170),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Save',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xffffffff),
                                                              fontFamily:
                                                                  'Poppins-Medium',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                          maxLines: 9999,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
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
