import 'package:eduguard/src/features/blogs/controllers/blogcontroller.dart';
import 'package:eduguard/src/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogForm extends StatelessWidget {
  const BlogForm({super.key});

  @override
  Widget build(BuildContext context) {
    final blogController = Get.put(AddBlogController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Blog'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New Blog Post',
                    style:
                        TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  ),
                  Text('CREATE BLOG', style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 24.0),
                ],
              ),
              Form(
                key: blogController.blogFormKey,
                child: Column(
                  children: [
                    // Blog Name Input Field
                    TextFormField(
                      controller: blogController.blogNameController,
                      validator: (value) =>
                          AppValidations.validateEmptyText('Blog Name', value),
                      decoration: const InputDecoration(
                        label: Text('Blog Name'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    // Blogger Name Input Field
                    TextFormField(
                      controller: blogController.bloggerNameController,
                      validator: (value) => AppValidations.validateEmptyText(
                          'Blogger Name', value),
                      decoration: const InputDecoration(
                        label: Text('Blogger Name'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    // Blog Content Input Field
                    TextFormField(
                      controller: blogController.blogContentController,
                      validator: (value) => AppValidations.validateEmptyText(
                          'Blog Content', value),
                      maxLines: 6,
                      decoration: const InputDecoration(
                        label: Text('Blog Content'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    // Blog Image Input Field
                    TextFormField(
                      controller: blogController.blogImageController,
                      validator: (value) => AppValidations.validateEmptyText(
                          'Blog Image URL', value),
                      decoration: const InputDecoration(
                        label: Text('Blog Image URL'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          blogController.addBlog();
                        },
                        child: const Text('Submit Blog'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
