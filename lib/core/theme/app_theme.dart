import 'package:bloc_clean_arch/core/constants/app_colors.dart';
import 'package:bloc_clean_arch/core/theme/custom_styles/custom_bottom_navigation_theme.dart';
import 'package:bloc_clean_arch/core/theme/custom_styles/custom_button_theme.dart';
import 'package:bloc_clean_arch/core/theme/custom_styles/custom_dialog_theme.dart';
import 'package:bloc_clean_arch/core/theme/custom_styles/custom_input_decoration_theme.dart';
import 'package:bloc_clean_arch/core/theme/custom_styles/custom_tab_theme.dart';
import 'package:bloc_clean_arch/core/theme/custom_styles/custom_text_theme.dart';
import 'package:flutter/material.dart';


class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    inputDecorationTheme: CustomInputDecorationTheme.theme,
    textTheme: CustomTextTheme.theme,
    dialogTheme: CustomDialogTheme.theme,
    elevatedButtonTheme: CustomButtonTheme.elevatedButtonTheme,
    textButtonTheme: CustomButtonTheme.textButtonTheme,
    navigationBarTheme: CustomBottomNavigationTheme.theme,
    tabBarTheme: CustomTabTheme.theme,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDarkColor,
    inputDecorationTheme: CustomInputDecorationTheme.theme,
    textTheme: CustomTextTheme.theme,
    dialogTheme: CustomDialogTheme.theme,
    elevatedButtonTheme: CustomButtonTheme.elevatedButtonTheme,
    textButtonTheme: CustomButtonTheme.textButtonTheme,
    navigationBarTheme: CustomBottomNavigationTheme.theme,
    tabBarTheme: CustomTabTheme.theme,
  );
}



  // static final appTheme = ThemeData(
  //     primaryColor: AppColors.primaryColor,
  //     scaffoldBackgroundColor:AppColors.backgroundColor,
  //     brightness: Brightness.light,
  //     snackBarTheme: const SnackBarThemeData(
  //       backgroundColor: AppColors.blackText,
  //       contentTextStyle: TextStyle(color: AppColors.backgroundColor),
  //     ),
  //     inputDecorationTheme: InputDecorationTheme(
  //         filled: true,
  //         fillColor: AppColors.fillColor,
  //         hintStyle: const TextStyle(
  //           color: AppColors.secondaryColor,
  //           fontWeight: FontWeight.w400,
  //         ),
  //         contentPadding: const EdgeInsets.all(16),
  //         border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(16),
  //             borderSide: BorderSide.none),
  //         enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(16),
  //             borderSide: BorderSide.none)),
  //     elevatedButtonTheme: ElevatedButtonThemeData(
  //         style: ElevatedButton.styleFrom(
  //             backgroundColor: AppColors.primaryColor,
  //             elevation: 0,
  //             textStyle:
  //                 const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(16)))));
