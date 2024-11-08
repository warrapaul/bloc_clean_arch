import 'package:bloc_clean_arch/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextTheme {
  static TextStyle _buildTextStyle(
      Color color, double size, FontWeight weight) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
      fontFamily: 'Roboto',
    );
  }

  static final TextTheme theme = TextTheme(
    displayLarge: _buildTextStyle(AppColors.textPrimary, 32, FontWeight.bold),
    displayMedium: _buildTextStyle(AppColors.textPrimary, 28, FontWeight.bold),
    displaySmall: _buildTextStyle(AppColors.textPrimary, 24, FontWeight.bold),
    headlineLarge: _buildTextStyle(AppColors.textPrimary, 22, FontWeight.w600),
    headlineMedium: _buildTextStyle(AppColors.textPrimary, 20, FontWeight.w600),
    headlineSmall: _buildTextStyle(AppColors.textPrimary, 18, FontWeight.w600),
    titleLarge: _buildTextStyle(AppColors.textPrimary, 18, FontWeight.w500),
    titleMedium: _buildTextStyle(AppColors.textPrimary, 16, FontWeight.w500),
    titleSmall: _buildTextStyle(AppColors.textPrimary, 14, FontWeight.w500),
    bodyLarge: _buildTextStyle(AppColors.textSecondary, 16, FontWeight.normal),
    bodyMedium: _buildTextStyle(AppColors.textSecondary, 14, FontWeight.normal),
    bodySmall: _buildTextStyle(AppColors.textSecondary, 12, FontWeight.normal),
    labelLarge: _buildTextStyle(AppColors.textPrimary, 14, FontWeight.w500),
    labelMedium: _buildTextStyle(AppColors.textPrimary, 12, FontWeight.w500),
    labelSmall: _buildTextStyle(AppColors.textPrimary, 10, FontWeight.w500),
  );

  // Additional custom text styles
  static final TextStyle error =
      _buildTextStyle(AppColors.error, 12, FontWeight.normal);
  static final TextStyle hint =
      _buildTextStyle(AppColors.textHint, 14, FontWeight.normal);
  static final TextStyle link =
      _buildTextStyle(AppColors.primaryColor, 14, FontWeight.normal);
}
