import 'package:eduguard/src/data/repositories/std_detection/std_repository.dart';
import 'package:eduguard/src/features/std_detection/models/std_model.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class STDController extends GetxController {
  static STDController get instance => Get.find();

  final isLoading = true.obs;
  final stdRepository = Get.put(STDRepository());

  final RxList<STDModel> featuredSTDs = <STDModel>[].obs;
  final RxList<STDModel> allSTDs = <STDModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedSTDs();
    super.onInit();
  }

//load stds
  Future<void> fetchFeaturedSTDs() async {
    try {
      //show loader while loading stds
      isLoading.value = true;

      //Fetch STDs
      final stds = await stdRepository.getAllSTDs();
      //Assign STDs
      allSTDs.assignAll(stds);

      featuredSTDs
          .assignAll(allSTDs.where((std) => std.isCommon ?? false).take(2));
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Oops!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
