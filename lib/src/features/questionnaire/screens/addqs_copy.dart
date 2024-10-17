import 'package:eduguard/src/features/questionnaire/controllers/qscontroller.dart';
import 'package:eduguard/src/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddQsCopy extends StatelessWidget {
  const AddQsCopy({super.key});

  @override
  Widget build(BuildContext context) {
    final qsController = Get.put(QSController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Questionnaire'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: qsController.qsFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Questionnaire Title
                const Text(
                  'New Questionnaire',
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),

                // Questionnaire Name Input Field
                TextFormField(
                  controller: qsController.qsNameController,
                  validator: (value) => AppValidations.validateEmptyText(
                      'Questionnaire Name', value),
                  decoration: const InputDecoration(
                    labelText: 'Questionnaire Name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => qsController.qsName.value = value,
                ),
                const SizedBox(height: 12.0),

                // Adder Name Input Field
                TextFormField(
                  controller: qsController.qSAdderNameController,
                  validator: (value) =>
                      AppValidations.validateEmptyText('Adder Name', value),
                  decoration: const InputDecoration(
                    labelText: 'Adder Name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => qsController.qSAdderName.value = value,
                ),
                const SizedBox(height: 12.0),

                // Questionnaire Content Input Field
                TextFormField(
                  controller: qsController.questionnaireController,
                  validator: (value) => AppValidations.validateEmptyText(
                      'Questionnaire Content', value),
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Questionnaire Content',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      qsController.questionnaire.value = value,
                ),
                const SizedBox(height: 12.0),

                // Questionnaire Image URL Input Field
                TextFormField(
                  controller: qsController.qSImageController,
                  validator: (value) => AppValidations.validateEmptyText(
                      'Questionnaire Image URL', value),
                  decoration: const InputDecoration(
                    labelText: 'Questionnaire Image URL',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => qsController.qSImage.value = value,
                ),
                const SizedBox(height: 24.0),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (qsController.qsFormKey.currentState!.validate()) {
                        qsController.addQS();
                      }
                    },
                    child: const Text('Submit Questionnaire'),
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
