import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class QualificationCard extends StatelessWidget {
  const QualificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000), offset: Offset(0, 4), blurRadius: 8),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.medscl2,
              width: 55,
              height: 55,
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lorem ipsum dolor Campus',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 12,
                          color: Color(0xff1e2425),
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.normal),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '(MBBS) lorem ipsum, specialized in Lorem and Lorem ipsum',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 12,
                                color: Color(0xff9fa2a2),
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.normal),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
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
    );
  }
}
