import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_themes.dart';

// StateProvider для управління темою
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  static const String _themePreferenceKey = 'theme_mode';

  ThemeNotifier() : super(ThemeMode.light);

  // Завантаження теми з SharedPreferences
  Future<void> loadThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themePreferenceKey);

    if (themeIndex != null) {
      state = ThemeMode.values[themeIndex];
    }
  }

  // Зміна теми і збереження у SharedPreferences
  Future<void> toggleTheme(bool isDarkMode) async {
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themePreferenceKey, state.index);
  }
}

/*
Maybe will use later
 */
// Допоміжний клас для роботи з темами
class ThemeProviderHelper {
  static ThemeData? getSelectedTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return ThisAppThemes.kLightTheme;
      case ThemeMode.dark:
        return ThisAppThemes.kDarkTheme;
      default:
        return ThisAppThemes.kLightTheme;
    }
  }
}
