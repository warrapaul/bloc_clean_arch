import 'package:bloc_clean_arch/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationTheme {
  static const double navHeight = 65.0;
  static const double iconSize = 24.0;
  static const double badgeSize = 20.0;

  static final NavigationBarThemeData theme = NavigationBarThemeData(
    height: navHeight,
    backgroundColor: AppColors.backgroundPrimary,
    indicatorColor: AppColors.primaryColor.withOpacity(0.12),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    elevation: 3,

    // Simple text styles for selected and unselected states
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
    ),

    // Simple icon theme
    iconTheme: WidgetStateProperty.all(
      const IconThemeData(
        size: iconSize,
        color: AppColors.textSecondary,
      ),
    ),
  );
}
