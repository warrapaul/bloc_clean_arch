import 'package:bloc_clean_arch/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDialogTheme {
  static TextStyle _buildTextStyle(Color color, double size, FontWeight weight) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
      fontFamily: 'Roboto',
    );
  }

  static ShapeBorder _buildShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.borderPrimary, width: 1),
    );
  }

  static final DialogTheme theme = DialogTheme(
    shape: _buildShape(),
    titleTextStyle: _buildTextStyle(AppColors.textPrimary, 20, FontWeight.bold),
    contentTextStyle:
        _buildTextStyle(AppColors.textSecondary, 16, FontWeight.normal),
    backgroundColor: AppColors.backgroundPrimary,
    elevation: 4,
  );

  // Custom styles for specific dialog elements
  static final TextStyle actionTextStyle = _buildTextStyle(AppColors.primaryColor, 14, FontWeight.w500);
  static const Color iconColor = AppColors.primaryColor;
  static const double iconSize = 28;

  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: AppColors.textOnPrimary,
    backgroundColor: AppColors.primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  static ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: AppColors.primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  // Specific styles for different dialog types
  static const confirmationIcon =  Icon(
    Icons.help_outline,
    color: AppColors.primaryColor,
    size: iconSize,
  );

  static const errorIcon = Icon(
    Icons.error_outline,
    color: AppColors.error,
    size: iconSize,
  );

  static const successIcon = Icon(
    Icons.check_circle_outline,
    color: AppColors.success,
    size: iconSize,
  );
}
