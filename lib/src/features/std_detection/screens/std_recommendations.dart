import 'package:eduguard/src/features/std_detection/controllers/specialist_controller.dart';
import 'package:eduguard/src/features/std_detection/wigets/specialist_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class STDRecommendations extends StatelessWidget {
  const STDRecommendations({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpecialistController());
    return Container(
      color: Colors.white,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xfff5f9f8),
        ),
        child: Center(
          child: SizedBox(
            width: 320, // Set the width to 320
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'YOUR \nRECOMMENDATIONS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 24,
                    color: Color(0xff1e2425),
                    fontFamily: 'Poppins-SemiBold',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'The following Medical Specialists are the best fitted recommendations for your infection',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 12,
                    color: Color(0xff9fa2a2),
                    fontFamily: 'Poppins-Regular',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0), // Spacing between items
                    child: SpecialistCard(
                        specialist: controller
                            .popularSpecialists[index]), // List item widget
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xff37be9d), width: 1),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Center(
                          child: Text(
                            'Back',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 12,
                              color: Color(0xff37be9d),
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
