import 'package:eduguard/src/data/repositories/std_detection/specialist_repository.dart';
import 'package:eduguard/src/features/std_detection/models/specialist_model.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class SpecialistController extends GetxController {
  static SpecialistController get instance => Get.find();

  final isLoading = true.obs;
  final specialistRepository = Get.put(SpecialistRepository());

  final RxList<SpecialistModel> popularSpecialists = <SpecialistModel>[].obs;
  final RxList<SpecialistModel> allSpecialists = <SpecialistModel>[].obs;
  @override
  void onInit() {
    fetchPopularSpecialists();
    super.onInit();
  }

  Future<void> fetchPopularSpecialists() async {
    try {
      //show loader while loading specialists
      isLoading.value = true;

      //Fetch STDs
      final specialists = await specialistRepository.getAllSpecialists();
      //Assign STDs
      allSpecialists.assignAll(specialists);
      popularSpecialists.assignAll(allSpecialists
          .where((specialist) => specialist.isPopular ?? false)
          .take(2));
    } catch (e) {
      AppSnackBars.errorSnackBar(
          title: 'Oops! Something went wrong.', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
