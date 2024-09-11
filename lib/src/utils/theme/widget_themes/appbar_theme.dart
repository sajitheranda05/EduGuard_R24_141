import 'package:flutter/material.dart';

class AppbarTheme {
  AppbarTheme._();

  static const appBarTheme =AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 28.0,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 28.0,
    ),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    )
  );

}