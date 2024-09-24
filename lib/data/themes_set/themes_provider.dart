import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_themes/app_themes.dart';

// StateNotifierProvider для управління темою
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

// Провайдер для отримання ThemeData відповідно до ThemeMode
final themeDataProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeProvider);
  return themeMode == ThemeMode.dark
      ? ThisAppThemes.kDarkTheme
      : ThisAppThemes.kLightTheme;
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  static const String _themePreferenceKey = 'theme_mode';

  ThemeNotifier() : super(ThemeMode.light) {
    loadThemeFromPreferences();
  }

  Future<void> loadThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themePreferenceKey);

    if (themeIndex != null) {
      state = ThemeMode.values[themeIndex];
    }
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themePreferenceKey, state.index);
    // Скидання кешу після зміни теми
    // cachedDataService.resetThemeCache();
  }
}

/*
Maybe will use later
 */

// Провайдер для отримання ColorScheme
// final colorSchemeProvider = Provider<ColorScheme>((ref) {
//   return ref.watch(themeDataProvider).colorScheme;
// });

// Провайдер для отримання TextTheme
// final textThemeProvider = Provider<TextTheme>((ref) {
//   return ref.watch(themeDataProvider).textTheme;
// });

// Допоміжний клас для роботи з темами
// class ThemeProviderHelper {
//   static ThemeData? getSelectedTheme(ThemeMode themeMode) {
//     switch (themeMode) {
//       case ThemeMode.light:
//         return ThisAppThemes.kLightTheme;
//       case ThemeMode.dark:
//         return ThisAppThemes.kDarkTheme;
//       default:
//         return ThisAppThemes.kLightTheme;
//     }
//   }
// }
