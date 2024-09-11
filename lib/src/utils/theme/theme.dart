import 'package:eduguard/src/utils/theme/widget_themes/appbar_theme.dart';
import 'package:eduguard/src/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:eduguard/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:eduguard/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:eduguard/src/utils/theme/widget_themes/textfield_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData themeData =ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: Colors.grey,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppbarTheme.appBarTheme,
    checkboxTheme: AppCheckboxTheme.checkboxThemeData,
    elevatedButtonTheme: AppElevatedButtonTheme.appElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.appOutlinedButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.appInputDecorationTheme,
  );
}