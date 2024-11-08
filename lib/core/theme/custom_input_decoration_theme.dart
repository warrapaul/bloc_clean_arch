import 'package:bloc_clean_arch/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomInputDecorationTheme {
  static TextStyle _buildTextStyle(Color color, {double size = 16.0}) {
    return TextStyle(color: color, fontSize: size);
  }

  static OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: color, width: 1.0),
    );
  }

  static final InputDecorationTheme theme = InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),

    // Borders
    enabledBorder: _buildBorder(AppColors.borderPrimary),
    errorBorder: _buildBorder(AppColors.error),
    focusedErrorBorder: _buildBorder(AppColors.error),
    focusedBorder: _buildBorder(AppColors.primaryColor),
    disabledBorder: _buildBorder(AppColors.disabledBackground),

    // Text styles
    suffixStyle: _buildTextStyle(AppColors.textPrimary),
    counterStyle: _buildTextStyle(AppColors.textSecondary, size: 12.0),
    floatingLabelStyle: _buildTextStyle(AppColors.primaryColor),
    errorStyle: _buildTextStyle(AppColors.error, size: 12.0),
    helperStyle: _buildTextStyle(AppColors.textSecondary, size: 12.0),
    hintStyle: _buildTextStyle(AppColors.textHint),
    labelStyle: _buildTextStyle(AppColors.textPrimary),
    prefixStyle: _buildTextStyle(AppColors.textPrimary),
  );
}


