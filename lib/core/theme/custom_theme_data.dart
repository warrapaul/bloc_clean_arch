import 'package:bloc_clean_arch/core/constants/app_colors.dart';
import 'package:bloc_clean_arch/core/theme/custom_bottom_navigation_theme.dart';
import 'package:bloc_clean_arch/core/theme/custom_button_theme.dart';
import 'package:bloc_clean_arch/core/theme/custom_dialog_theme.dart';
import 'package:bloc_clean_arch/core/theme/custom_input_decoration_theme.dart';
import 'package:bloc_clean_arch/core/theme/custom_tab_theme.dart';
import 'package:bloc_clean_arch/core/theme/custom_text_theme.dart';
import 'package:flutter/material.dart';

class CustomThemeData {
  static ThemeData themeData = ThemeData(
      primaryColor: AppColors.primaryColor,
      inputDecorationTheme: CustomInputDecorationTheme.theme,
      textTheme: CustomTextTheme.theme,
      dialogTheme: CustomDialogTheme.theme,
      elevatedButtonTheme: CustomButtonTheme.elevatedButtonTheme,
      textButtonTheme: CustomButtonTheme.textButtonTheme,
      navigationBarTheme: CustomBottomNavigationTheme.theme,
      tabBarTheme: CustomTabTheme.theme,
    );
}
