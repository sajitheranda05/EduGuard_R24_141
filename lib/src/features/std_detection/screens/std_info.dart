import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class STDInfo extends StatelessWidget {
  const STDInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xfff5f9f8),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0, // Center horizontally
              right: 0, // Center horizontally
              top: 0, // Remove the specific top value
              bottom: 0, // Center vertically
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center content vertically
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center content horizontally
                children: [
                  Image.asset(
                    AppImages.info,
                    width: 300,
                    height: 215,
                  ),
                  const SizedBox(height: 20),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'STD Detection',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 24,
                          color: Color(0xff1e2425),
                          fontFamily: 'Poppins-SemiBold',
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 300,
                        child: Text(
                          'Lorem ipsum dolor sit amet consectetur. Adipiscing fringilla porttitor at purus ullamcorper neque at quisque. Sollicitudin sagittis id nibh nisi. Sit tortor pellentesque sem euismod mattis nec odio odio blandit. Morbi tellus quam sit porttitor eget sed amet. Commodo nisl tortor orci morbi tempus. Nibh mus sit orci tellus elit mattis nulla orci.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            color: Color(0xff9fa2a2),
                            fontFamily: 'Poppins-Regular',
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center buttons horizontally
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xff37be9d), width: 1),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Center(
                            // Center text inside the button
                            child: Text(
                              'Back',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14,
                                color: Color(0xff37be9d),
                                fontFamily: 'Poppins-Medium',
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 9999,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 60),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xff0c6170),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Center(
                            // Center text inside the button
                            child: Text(
                              'Detect Now',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14,
                                color: Color(0xffffffff),
                                fontFamily: 'Poppins-Medium',
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 9999,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
