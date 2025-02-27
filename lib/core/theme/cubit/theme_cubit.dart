import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/core/theme/repository/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeRepository _repository;
  ThemeCubit(this._repository) : super(const ThemeState(themeMode: ThemeMode.system));

  void toggleTheme() {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _repository.saveThemeMode(newMode);


    emit(ThemeState(themeMode: newMode));
  }

  void initializeTheme() {
    final savedTheme = _repository.getThemeMode();
    emit(ThemeState(themeMode: savedTheme));
  }

  void setThemeMode(ThemeMode mode) {
    _repository.saveThemeMode(mode);
    emit(ThemeState(themeMode: mode));
  }
}
