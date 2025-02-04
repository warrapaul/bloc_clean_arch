import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  final SharedPreferences sharedPreferences;

  ThemeRepository({required this.sharedPreferences});

  ThemeMode getThemeMode(){
    try {
      final themeIndex =
          sharedPreferences.getInt('theme_mode') ?? ThemeMode.system.index;
      return ThemeMode.values[themeIndex];
    } catch (e) {
      return ThemeMode.system;
    }
   
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    await sharedPreferences.setInt('theme_mode', mode.index);
  }
}
