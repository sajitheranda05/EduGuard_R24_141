import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:flutter/material.dart';

class AppTextFieldTheme {
  AppTextFieldTheme._();

  static InputDecorationTheme  appInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.darkGrey,
    suffixIconColor: AppColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: 16.0, color: AppColors.black),
    hintStyle: const TextStyle().copyWith(fontSize: 18.0, color: AppColors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: AppColors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(width: 1, color: AppColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(width: 1, color: AppColors.grey),
    ),
    focusedBorder:const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(width: 1, color: AppColors.primary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(width: 1, color: AppColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(width: 2, color: AppColors.warning),
    ),
  );
}