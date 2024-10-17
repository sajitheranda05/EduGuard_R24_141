import 'package:eduguard/src/features/blogs/Screen/blogpostview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<StatefulWidget> createState() => _Success();
}

class _Success extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        width: 360,
        height: 800,
        decoration: BoxDecoration(
          color: const Color(0xfff5f9f8),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 30,
              width: 300,
              top: 196,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/image_7023692.png',
                    width: 300,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          //Get.to(const BlogPostView());
                        },
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: const Text(
                                        'Lorem ipsum dolor sit amet consectetur.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
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
                              const SizedBox(height: 50),
                              GestureDetector(
                                onTap: () {
                                  // Get.to(const BlogPostView());
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
                                          'View',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 12,
                                              color: Color(0xffffffff),
                                              fontFamily: 'Poppins-Medium',
                                              fontWeight: FontWeight.normal),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
