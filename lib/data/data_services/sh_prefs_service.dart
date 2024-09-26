import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs; // Instance of SharedPreferences
  SharedPreferencesService(this._prefs);

  /// Saves the current theme mode (light or dark) in SharedPreferences.
  /// This method stores the theme mode as an integer value, corresponding
  /// to the index of the [ThemeMode] enumeration.
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _prefs.setInt('theme_mode', themeMode.index);
  }

  /// Loads the theme mode from SharedPreferences.
  /// If no value is stored, it defaults to [ThemeMode.light].
  /// Returns the corresponding [ThemeMode] based on the stored index.
  ThemeMode loadThemeMode() {
    final themeIndex = _prefs.getInt('theme_mode') ?? ThemeMode.light.index;
    return ThemeMode.values[themeIndex];
  }

  /// Saves the current chart type (isFirstChart) in SharedPreferences.
  Future<void> saveChartPreference(bool isFirstChart) async {
    await _prefs.setBool('isFirstChart', isFirstChart);
  }

  /// Loads the chart preference from SharedPreferences.
  bool? loadChartPreference() {
    return _prefs.getBool('isFirstChart');
  }
//
}
