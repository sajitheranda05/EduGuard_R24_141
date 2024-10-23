import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
//import 'package:eduguard/src/features/blogs/Screen/addblog.dart';
import 'package:eduguard/src/features/blogs/Screen/addblog_copy.dart';
import 'package:eduguard/src/features/blogs/controllers/blogcontroller.dart';
import 'package:eduguard/src/features/blogs/widget/blog.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BlogPost extends StatefulWidget {
  const BlogPost({super.key});

  @override
  State<StatefulWidget> createState() => _BlogPost();
}

class _BlogPost extends State<BlogPost> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddBlogController());
    // Get the screen size
    final String? selectedCategory = Get.arguments?['Catogary'];

    final size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Blog Post',
                style: TextStyle(fontSize: 16.0),
              )
            ],
          ),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: size.width, // Set the container width to the screen width

            color: Colors.white,

            child: Container(
              width: size
                  .width, // Ensure this container also takes full screen width

              //height: size.height, // Set the height to the screen height

              decoration: const BoxDecoration(
                color: Color(0xfff5f9f8),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search bar container
                    // Search bar container
                    Row(
                      children: [
                        // Search bar container
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              border: Border.all(
                                color: const Color(0xffe8e8e8),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.search_outlined,
                                  color: Color(0xFFBFC5C6),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {
                                      controller.updateSearchQuery(value);
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 12,
                                        color: Color(0xff9fa2a2),
                                        fontFamily: 'Poppins-Regular',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 10), // Space between search bar and icon
                        // Add Icon next to the search bar
                        GestureDetector(
                          onTap: () {
                            // Your action when add icon is clicked
                            Get.to(const AddBlogCopy()); // Example action
                          },
                          child: const Icon(
                            Icons.add_circle_outline, // Add icon
                            color: Color(0xFFBFC5C6),
                            size: 30, // You can adjust the size as needed
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    /*GridView.builder(

                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,

                        mainAxisSpacing: 10.0,

                        crossAxisSpacing: 10.0,

                        mainAxisExtent:
                            200, // Set height relative to screen height
                      ),
                      itemBuilder: (_, index) => const blog(),
                    ),*/
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(), // Loader widget
                        );
                      }
                      if (controller.paginatedblogs.isEmpty) {
                        return const Center(
                          child: Text('No data found'),
                        );
                      }
                      return GridView.builder(
                        itemCount: controller.paginatedblogs.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          mainAxisExtent: 260,
                        ),
                        itemBuilder: (_, index) {
                          final blog = controller.paginatedblogs[index];
                          return blog_card(blog1: blog);
                        },
                      );
                    }),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: controller.prevPage,
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors
                                      .transparent, // Transparent background
                                  foregroundColor:
                                      const Color(0xff37be9d), // Text color
                                  side: const BorderSide(
                                    color: Color(0xff37be9d),
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        40), // Rounded corners
                                  ),
                                  minimumSize:
                                      const Size(80, 35), // Button size
                                ),
                                child: const Text(
                                  'Prev',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins-Medium',
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                              TextButton(
                                onPressed: controller.nextPage,
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors
                                      .transparent, // Transparent background
                                  foregroundColor:
                                      const Color(0xff37be9d), // Text color
                                  side: const BorderSide(
                                    color: Color(0xff37be9d),
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        40), // Rounded corners
                                  ),
                                  minimumSize:
                                      const Size(80, 35), // Button size
                                ),
                                child: const Text(
                                  'Next',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins-Medium',
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
