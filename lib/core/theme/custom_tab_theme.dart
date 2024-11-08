import 'package:bloc_clean_arch/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTabTheme {
  // static const double tabHeight = 56.0;
  static const TabBarTheme theme = TabBarTheme(
    labelColor: AppColors.primaryColor,
    unselectedLabelColor: AppColors.textSecondary,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorColor: Colors.red,
    labelStyle:  TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
    unselectedLabelStyle:  TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    
    // // Custom indicator decoration
    // indicator: BoxDecoration(
    //   border: Border(
    //     bottom: BorderSide(
    //       color: AppColors.primaryColor,
    //       width: 3.0,
    //     ),
    //   ),    
    // ),
  );
}
