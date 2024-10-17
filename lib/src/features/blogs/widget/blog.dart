import 'package:eduguard/src/features/blogs/Screen/blogpostview.dart';
import 'package:eduguard/src/features/blogs/model/blogmodel.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class blog_card extends StatelessWidget {
  const blog_card({super.key, required this.blog1});
  final BlogModel blog1;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: AspectRatio(
                      aspectRatio: 2 / 1, // Set the aspect ratio to 2:1
                      child: Image.network(
                        blog1.BlogImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    //height: 30,
                    child: Text(
                      blog1.BlogName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 14,
                          color: Color(0xff1e2425),
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.normal),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Get.to(BlogPostView(
                  blog1: blog1,
                ));
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 20,
                      child: const Padding(
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'View Artical',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 12,
                                  color: Color(0xff37be9d),
                                  fontFamily: 'Poppins-Medium',
                                  fontWeight: FontWeight.normal),
                              maxLines: 2,
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
          ],
        ),
      ),
    );
  }
}
