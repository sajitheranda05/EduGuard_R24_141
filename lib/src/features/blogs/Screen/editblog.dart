/*import 'package:eduguard/src/features/blogs/controllers/blogcontroller.dart';
import 'package:eduguard/src/features/blogs/model/blogmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'blog_controller.dart'; // Assuming you have a BlogController to manage the state and logic.

class UpdateBlogPage extends StatelessWidget {
  final String blogID; // ID of the blog to update
  final AddBlogController blogController = Get.find<AddBlogController>();
  final BlogModel blog;

  // Constructor to accept the blogId
  UpdateBlogPage({required this.blog, required this.blogID});

  @override
  Widget build(BuildContext context) {
    // Fetch the blog details using the blogId
    var blog1 = blogController.getBlogById(blog);

    // Pre-fill the text controllers with the existing blog data
    blogController.blogNameController.text = blog.BlogName;
    blogController.bloggerNameController.text = blog.BloggerName;
    blogController.blogContentController.text = blog.Blog;
    blogController.blogImageController.text = blog.BlogImage;

    // Controllers for the text fields
    final TextEditingController blogNameController =
        TextEditingController(text: blog1?.title ?? '');
    final TextEditingController bloggerNameController =
        TextEditingController(text: blog1?.blogger ?? '');
    final TextEditingController contentController =
        TextEditingController(text: blog1?.name ?? '');
    /*final TextEditingController blogImageController =
        TextEditingController(text: blog1?.image ?? '');*/
    final TextEditingController CatogaryController =
        TextEditingController(text: blog1?.catogary ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Blog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: blogNameController,
              decoration: InputDecoration(
                labelText: 'Blog Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Blog Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 6,
            ),
            SizedBox(height: 20),
            TextField(
              controller: bloggerNameController,
              decoration: InputDecoration(
                labelText: 'Blogger Name',
                border: OutlineInputBorder(),
              ),
              maxLines: 6,
            ),
            /*SizedBox(height: 20),
            TextField(
              controller: blogImageController,
              decoration: InputDecoration(
                labelText: 'Blog Image',
                border: OutlineInputBorder(),
              ),
              maxLines: 6,
            ),*/
            SizedBox(height: 5),
            TextField(
              controller: CatogaryController,
              decoration: InputDecoration(
                labelText: 'Blog Catogary',
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Update the blog using the controller
                blogController.updateBlog(blog1);

                // Show a success message
                Get.snackbar('Success', 'Blog updated successfully',
                    snackPosition: SnackPosition.BOTTOM);

                // Navigate back to the previous screen
                Get.back();
              },
              child: Text('Update Blog'),
            ),
          ],
        ),
      ),
    );
  }
}
*/