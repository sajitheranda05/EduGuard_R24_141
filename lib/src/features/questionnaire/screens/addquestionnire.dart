/*import 'package:eduguard/src/features/questionnaire/controllers/qscontroller.dart';
import 'package:eduguard/src/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddQSCopy extends StatelessWidget {
  const AddQSCopy({super.key});

  @override
  Widget build(BuildContext context) {
    final qsController = Get.put(QSController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Blog'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: QSController.questionnaireFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Blog Title
                const Text(
                  'New Blog Post',
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),

                // Blog Name Input Field
                TextFormField(
                  controller: QSController.questionnaireNameController,
                  validator: (value) =>
                      AppValidations.validateEmptyText('Blog Name', value),
                  decoration: const InputDecoration(
                    labelText: 'Blog Name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      QSController.questionnaireName.value = value,
                ),
                const SizedBox(height: 12.0),

                // Blogger Name Input Field
                TextFormField(
                  controller: QSController.questionnaireAdderNameController,
                  validator: (value) =>
                      AppValidations.validateEmptyText('Blogger Name', value),
                  decoration: const InputDecoration(
                    labelText: 'Blogger Name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => QSController
                      .questionnaireAdderNameController.value = value,
                ),
                const SizedBox(height: 12.0),

                // Blog Content Input Field
                TextFormField(
                  controller: QSController.blogContentController,
                  validator: (value) =>
                      AppValidations.validateEmptyText('Blog Content', value),
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Blog Content',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => QSController.blogContent.value = value,
                ),
                const SizedBox(height: 12.0),

                // Blog Image URL Input Field
                TextFormField(
                  controller: QSController.blogImageController,
                  validator: (value) =>
                      AppValidations.validateEmptyText('Blog Image URL', value),
                  decoration: const InputDecoration(
                    labelText: 'Blog Image URL',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      QSController.questionnaireImage.value = value,
                ),
                const SizedBox(height: 24.0),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (QSController.questionnaireFormKey.currentState!
                          .validate()) {
                        QSController.addBlog();
                      }
                    },
                    child: const Text('Submit Questionnnaire'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/