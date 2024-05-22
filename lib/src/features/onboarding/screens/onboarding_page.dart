import 'package:eduguard/src/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.image, required this.title, required this.desc,
  });

  final String image, title, desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Image(
              width: AppHelperFunctions.screenWidth() * 0.8 ,
              height: AppHelperFunctions.screenHeight() * 0.6,
              image: AssetImage(image)
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0,),
          Text(
            desc,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}