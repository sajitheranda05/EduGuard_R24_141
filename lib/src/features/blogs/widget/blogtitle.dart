import 'package:eduguard/src/features/blogs/Screen/blogpost.dart';
import 'package:eduguard/src/features/blogs/model/blogmodel.dart';
//import 'package:eduguard/src/features/blogs/blogpost.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogTitle extends StatelessWidget {
  const BlogTitle({super.key, required this.blog});
  final BlogModel blog;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const BlogPost(),
            arguments: {'Catogary': 'SelectedCategoryName'});
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xff37be9d),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      blog.Catogary,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
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
    );
  }
}
