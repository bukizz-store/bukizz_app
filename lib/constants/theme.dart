import 'package:bukizz_1/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData instance = lightThemeData;
  static ThemeData lightThemeData = ThemeData(
    hintColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      background: Colors.white,
    ),
    useMaterial3: true,
  );
}