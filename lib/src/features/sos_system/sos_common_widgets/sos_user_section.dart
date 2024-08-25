import 'package:eduguard/src/common_widgets/Screens/circular_image.dart';
import 'package:flutter/material.dart';

class CustomSOSUSerImageSection extends StatelessWidget {
  const CustomSOSUSerImageSection({
    super.key,
    required this.contactName,
    required this.image
  });

  final String image;
  final String contactName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(2.0),
            ),
            child: CustomCircularImage(image: image)
        ),
        const SizedBox(height: 4.0,),
        Text(
          contactName,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
