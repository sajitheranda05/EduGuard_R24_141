import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/questionnaire/controllers/qscontroller.dart';
import 'package:eduguard/src/features/questionnaire/widget/questionniretitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Questionnairehome extends StatefulWidget {
  const Questionnairehome({super.key});

  @override
  State<StatefulWidget> createState() => _Questionnairehome();
}

class _Questionnairehome extends State<Questionnairehome> {
  @override
  Widget build(BuildContext context) {
    //final controller = AddBlogController.instance;
    final controller = Get.put(QSController());
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Matteo Perera...',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              Text(
                'Questionnaire  Platform.',
                style: TextStyle(fontSize: 16.0),
              )
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xfff5f9f8),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  width: 410,
                  top: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /*ListView.builder(
                                      itemCount: 8,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index) => const Padding(
                                        padding: EdgeInsets.only(
                                            bottom:
                                                10.0), // Spacing between items
                                        child: BlogTitle(), // List item widget
                                      ),
                                    ),*/

                                    Obx(() {
                                      if (controller.isLoading.value) {
                                        return const Center(
                                          child:
                                              CircularProgressIndicator(), // Loader widget
                                        );
                                      }
                                      if (controller.paginatedqs.isEmpty) {
                                        return const Center(
                                          child: Text('No data found'),
                                        );
                                      }
                                      return GridView.builder(
                                        itemCount:
                                            controller.paginatedqs.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          mainAxisSpacing: 10.0,
                                          crossAxisSpacing: 10.0,
                                          mainAxisExtent: 40,
                                        ),
                                        itemBuilder: (_, index) {
                                          final qs =
                                              controller.paginatedqs[index];
                                          return QuestionnireTitle(qs: qs);
                                        },
                                      );
                                    }),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: controller.prevPage,
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .transparent, // Transparent background
                                                  foregroundColor: const Color(
                                                      0xff37be9d), // Text color
                                                  side: const BorderSide(
                                                    color: Color(0xff37be9d),
                                                    width: 1,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40), // Rounded corners
                                                  ),
                                                  minimumSize: const Size(
                                                      80, 35), // Button size
                                                ),
                                                child: const Text(
                                                  'Prev',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        'Poppins-Medium',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 40),
                                              TextButton(
                                                onPressed: controller.nextPage,
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .transparent, // Transparent background
                                                  foregroundColor: const Color(
                                                      0xff37be9d), // Text color
                                                  side: const BorderSide(
                                                    color: Color(0xff37be9d),
                                                    width: 1,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40), // Rounded corners
                                                  ),
                                                  minimumSize: const Size(
                                                      80, 35), // Button size
                                                ),
                                                child: const Text(
                                                  'Next',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        'Poppins-Medium',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    decoration:
                                                        TextDecoration.none,
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
                          ],
                        ),
                      ],
                    ),
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
