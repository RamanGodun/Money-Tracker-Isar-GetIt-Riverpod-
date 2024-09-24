import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _prefs.setInt('theme_mode', themeMode.index);
  }

  ThemeMode loadThemeMode() {
    final themeIndex = _prefs.getInt('theme_mode') ?? ThemeMode.light.index;
    return ThemeMode.values[themeIndex];
  }

  //  інші методи для взаємодії з SharedPreferences
}
