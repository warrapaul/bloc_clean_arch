import 'package:bloc_clean_arch/core/configs/del_theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final appTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor:AppColors.backgroundColor,
      brightness: Brightness.light,
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.blackText,
        contentTextStyle: TextStyle(color: AppColors.backgroundColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.fillColor,
          hintStyle: const TextStyle(
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              elevation: 0,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)))));
}
