import 'package:eduguard/src/common_widgets/Screens/circular_image.dart';
import 'package:flutter/material.dart';

class CustomSOSUSerImageSection extends StatelessWidget {
  const CustomSOSUSerImageSection({
    super.key,
    required this.contactName,
    required this.image,
    this.isSelected =false,
    this.borderColor =Colors.transparent,
  });

  final String image;
  final String contactName;
  final bool isSelected;
  final Color borderColor;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 4.0), // Border around the image
          ),
          child: CircleAvatar(
            radius: 28.0,
            backgroundImage: AssetImage(image),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          contactName,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

}
