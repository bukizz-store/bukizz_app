import 'package:bukizz/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData instance = lightThemeData;
  static ThemeData lightThemeData = ThemeData(
    hintColor: Colors.grey,

    scaffoldBackgroundColor:Color(0xFFF5FAFF),//Color(0xFFE0EFFF)
    splashColor: Colors.transparent,
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
      primary: AppColors.primaryColor,
      background: Colors.white,
    ),
    useMaterial3: true,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
  );
}