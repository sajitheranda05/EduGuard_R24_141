import 'package:eduguard/src/features/onboarding/controllers/onboarding_controller.dart';
import 'package:eduguard/src/features/onboarding/screens/onboarding_page.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:eduguard/src/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          //Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: AppImages.onBoardingImage_welcome,
                title: AppText.onBoardingText_welcome_title,
                desc: AppText.onBoardingText_welcome_desc,
              ),
              OnBoardingPage(
                image: AppImages.onBoardingImage_education,
                title: AppText.onBoardingText_education_title,
                desc: AppText.onBoardingText_education_title,
              ),
              OnBoardingPage(
                image: AppImages.onBoardingImage_sos,
                title: AppText.onBoardingText_sos_title,
                desc: AppText.onBoardingText_sos_desc,
              ),
              OnBoardingPage(
                image: AppImages.onBoardingImage_blogs,
                title: AppText.onBoardingText_blogs_title,
                desc: AppText.onBoardingText_blogs_desc,
              ),
              OnBoardingPage(
                image: AppImages.onBoardingImage_std,
                title: AppText.onBoardingText_std_title,
                desc: AppText.onBoardingText_std_desc,
              ),
            ],
          ),

          //Skip Button
          Positioned(
              top: kToolbarHeight,
              right: 24.0,
              child: TextButton(
                onPressed: () => controller.skipPage(),
                child: const Text('Skip'),
              )
          ),

          //SmoothPageIndicator
          Positioned(
            bottom: kBottomNavigationBarHeight,
            left: 24.0,
            child: SmoothPageIndicator(
              controller: controller.pageController,
              onDotClicked: controller.dotNavigationOnClick,
              count: 5,
              effect: const ExpandingDotsEffect(activeDotColor: Colors.black, dotHeight: 6),
            ),
          ),

          //Circular Button
          Positioned(
            right: 24.0,
            bottom: kBottomNavigationBarHeight,
            child: ElevatedButton(
              onPressed: () => controller.nextPage(),
              style:ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.black,
              ),
              child: const Icon(Icons.keyboard_arrow_right_outlined),
            ),
          ),

        ],
      ),
    );
  }
}