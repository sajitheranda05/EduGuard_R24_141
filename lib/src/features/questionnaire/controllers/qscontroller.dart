import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/questionnaire/questionnaire_repository.dart';
import 'package:eduguard/src/features/questionnaire/model/questionnaremodel.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QSController extends GetxController {
  static QSController get instance => Get.find();
  final questionnaireRepository = Get.put(QuestionnaireRepository());

  final isLoading = true.obs;
  final RxList<Questionnaremodel> allQs = <Questionnaremodel>[].obs;
  final RxList<Questionnaremodel> paginatedqs = <Questionnaremodel>[].obs;

  final int itemsPerPage = 10;
  final RxInt currentPage = 0.obs;

  @override
  void onInit() {
    fetchPaginatedqs();
    super.onInit();
  }

  final RxString searchQuery = ''.obs;

  // Reactive variables for form fields
  final qsName = ''.obs;
  final qSAdderName = ''.obs;
  final questionnaire = ''.obs;
  final qSImage = ''.obs;
  final category = ''.obs;

  // Form key
  final GlobalKey<FormState> qsFormKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController qsNameController = TextEditingController();
  final TextEditingController qSAdderNameController = TextEditingController();
  final TextEditingController questionnaireController = TextEditingController();
  final TextEditingController qSImageController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  // Method to add a new QS
  Future<void> addQS() async {
    if (!qsFormKey.currentState!.validate()) {
      return; // Form is invalid
    }

    try {
      isLoading.value = true;

      // Create a Questionnaremodel instance
      final qs = Questionnaremodel(
        ID: '', // Firebase will auto-generate an ID
        QsName: qsName.value,
        Qs: questionnaire.value,
        QSAdderName: qSAdderName.value,
        QSImage: qSImage.value,
        Catogary: category.value,
      );

      // Save the QS record
      await questionnaireRepository.saveQsRecord(qs.toJson());
      AppSnackBars.successSnackBar(
          title: 'Success', message: 'QS added successfully!');

      // Clear the form after saving
      clearForm();
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Oops!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Method to update an existing QS
  Future<void> updateQs(Questionnaremodel updatedQs) async {
    try {
      isLoading.value = true;

      await questionnaireRepository.updateQsDetails(
          updatedQs.ID, updatedQs.toJson());
      Get.snackbar('Success', 'Questionnaire updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Method to delete a QS by ID
  Future<void> deleteQs(String qsId) async {
    try {
      isLoading.value = true;
      await questionnaireRepository.removeQsDetails(qsId);
      Get.snackbar('Success', 'QS deleted successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch QS details by ID
  Future<Questionnaremodel> fetchQsDetails(String qsId) async {
    try {
      final documentSnapshot =
          await questionnaireRepository.fetchQsDetails(qsId);
      return Questionnaremodel.fromSnapshot(
          documentSnapshot as DocumentSnapshot<Map<String, dynamic>>);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return Questionnaremodel.empty();
    }
  }

  // Method to update a single field of the QS
  Future<void> updateSingleField(
      String qsId, Map<String, dynamic> updatedField) async {
    try {
      await questionnaireRepository.updateSingleQsField(qsId, updatedField);
      Get.snackbar('Success', 'Field updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Clear the form fields
  void clearForm() {
    qsFormKey.currentState?.reset();
    qsName.value = '';
    qSAdderName.value = '';
    questionnaire.value = '';
    qSImage.value = '';
    category.value = '';
  }

  // Fetch QS records with pagination
  Future<void> fetchPaginatedqs({String? category}) async {
    try {
      isLoading.value = true;
      final qsList = await questionnaireRepository.getallQs(limit: 10);

      if (category != null && category.isNotEmpty) {
        allQs.assignAll(qsList.where((qs) => qs.Catogary == category));
      } else {
        allQs.assignAll(qsList); // Show all if no category is provided
      }

      paginateQs();
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Oops!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void paginateQs() {
    final startIndex = currentPage.value * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    if (allQs.isEmpty) {
      paginatedqs.clear();
    } else {
      paginatedqs.assignAll(allQs.sublist(
          startIndex, endIndex > allQs.length ? allQs.length : endIndex));
    }
  }
  /* */

  // Navigate to the next page
  void nextPage() {
    if ((currentPage.value + 1) * itemsPerPage < allQs.length) {
      currentPage.value++;
      paginateQs();
    }
  }

  // Navigate to the previous page
  void prevPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      paginateQs();
    }
  }

  // Filter QS by search query
  void filterQs() {
    if (searchQuery.value.isEmpty) {
      paginateQs(); // Show all QS if no search query
    } else {
      paginatedqs.assignAll(allQs.where((qs) =>
          qs.QsName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          qs.QSAdderName.toLowerCase()
              .contains(searchQuery.value.toLowerCase())));
    }
  }

  // Update the search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterQs();
  }
}
