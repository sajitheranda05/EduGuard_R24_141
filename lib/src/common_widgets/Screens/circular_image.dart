import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:flutter/material.dart';

class CustomCircularImage extends StatelessWidget {
  const CustomCircularImage({
    super.key,
    required this.image,
    this.isNetworkImage =false,
    this.overlayColor,
    this.backgroundColor,
    this.width =56,
    this.height =56,
    this.padding =4,
    this.isSelected=false,
  });

  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;
  final isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        margin: const EdgeInsets.only(bottom: 2.0),
        decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.secondary,
        borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: CircleAvatar(
            backgroundColor: isSelected? Colors.black : Colors.transparent,
            radius: 72,
            backgroundImage: AssetImage(image),

          ),
        ),
    );
  }
}
