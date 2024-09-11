import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:flutter/material.dart';

class AppCheckboxTheme {
  AppCheckboxTheme._();
  
  static CheckboxThemeData checkboxThemeData =CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );
}