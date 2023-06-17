import 'package:flutter/material.dart';

import 'appcolors.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: AppColors.primary,
  brightness: Brightness.light,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 16.0),
    bodyMedium: TextStyle(fontSize: 14.0),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    textTheme: ButtonTextTheme.primary,
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    labelStyle: TextStyle(color: Colors.grey),
    hintStyle: TextStyle(color: Colors.grey),
  ),
);
