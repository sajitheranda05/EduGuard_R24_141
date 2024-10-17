import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<StatefulWidget> createState() => _Comments();
}

class _Comments extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Comments',
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
            height: 806,
            decoration: const BoxDecoration(
              color: Color(0xfff5f9f8),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  width: 360,
                  top: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        'images/image_7023814.png',
                                                                        width:
                                                                            24,
                                                                        height:
                                                                            24,
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              20),
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              const Text(
                                                                            'kalyaperera@gmail.com',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style: TextStyle(
                                                                                decoration: TextDecoration.none,
                                                                                fontSize: 15,
                                                                                color: Color(0xff050505),
                                                                                fontFamily: 'Poppins-Medium',
                                                                                fontWeight: FontWeight.normal),
                                                                            maxLines:
                                                                                9999,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      const Text(
                                                                    'Lorem ipsum dolor sit amet consectetur.\n Egestas sed nibh mauris erat pellentesque quam ultrices semper orci. \nEt quis tristique id risus ipsum nunc id. \nEu odio libero molestie scelerisque sed risus pellentesque.\n Ac aliquet sed hac pellentesque vitae sapien gravida varius. ',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .none,
                                                                        fontSize:
                                                                            16,
                                                                        color: Color(
                                                                            0xff9fa2a2),
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
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        'images/image_753869.png',
                                                                        width:
                                                                            24,
                                                                        height:
                                                                            24,
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              20),
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              const Text(
                                                                            'kalyaperera@gmail.com',
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style: TextStyle(
                                                                                decoration: TextDecoration.none,
                                                                                fontSize: 15,
                                                                                color: Color(0xff050505),
                                                                                fontFamily: 'Poppins-Medium',
                                                                                fontWeight: FontWeight.normal),
                                                                            maxLines:
                                                                                9999,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      const Text(
                                                                    'Lorem ipsum dolor sit amet consectetur.\n Egestas sed nibh mauris erat pellentesque quam ultrices semper orci. \nEt quis tristique id risus ipsum nunc id. \nEu odio libero molestie scelerisque sed risus pellentesque.\n Ac aliquet sed hac pellentesque vitae sapien gravida varius. ',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .none,
                                                                        fontSize:
                                                                            16,
                                                                        color: Color(
                                                                            0xff9fa2a2),
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xccffffff),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0x14000000),
                                      offset: Offset(0, -4),
                                      blurRadius: 8),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffffffff),
                                          border: Border.all(
                                              color: const Color(0xffe8e8e8),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              top: 10,
                                              right: 15,
                                              bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Type a comment',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff9fa2a2),
                                                        fontFamily:
                                                            'Poppins-Regular',
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    maxLines: 9999,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 145),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Image.asset(
                                      'images/image_I70238172041995.png',
                                      width: 35.001,
                                      height: 35,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
