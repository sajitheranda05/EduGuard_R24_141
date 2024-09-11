import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/std_detection/controllers/specialist_controller.dart';
import 'package:eduguard/src/features/std_detection/wigets/specialist_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialistsPage extends StatelessWidget {
  const SpecialistsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = SpecialistController.instance;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const CustomAppBar(
          title: Text(
            'Medical Specialists',
            style: TextStyle(fontSize: 18.0),
          ),
          showBackArrow: true, // Show the back arrow
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xfff6faf9),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  border: Border.all(
                                    color: const Color(0xffe8e8e8),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.search_outlined,
                                      color: Color(0xFFBFC5C6),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Search',
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          color: Color(0xff9fa2a2),
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.normal),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Obx(() {
                                if (controller.isLoading.value) {
                                  return const Center(
                                    child:
                                        CircularProgressIndicator(), // Loader widget
                                  );
                                }
                                if (controller.allSpecialists.isEmpty) {
                                  return const Center(
                                    child: Text('No data found'),
                                  );
                                }
                                return GridView.builder(
                                  itemCount: controller.allSpecialists.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 10.0,
                                    crossAxisSpacing: 10.0,
                                    mainAxisExtent: 110,
                                  ),
                                  itemBuilder: (_, index) {
                                    final specialist =
                                        controller.allSpecialists[index];
                                    return SpecialistCard(
                                        specialist: specialist);
                                  },
                                );
                              }),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 70,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xff37be9d),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Prev',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 12,
                                                    color: Color(0xff37be9d),
                                                    fontFamily:
                                                        'Poppins-Medium',
                                                    fontWeight:
                                                        FontWeight.normal),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 40),
                                        Container(
                                          width: 70,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xff37be9d),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Next',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 12,
                                                    color: Color(0xff37be9d),
                                                    fontFamily:
                                                        'Poppins-Medium',
                                                    fontWeight:
                                                        FontWeight.normal),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
