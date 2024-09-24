import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DOMAIN/Services/_service_locator.dart';
import '../../DOMAIN/Services/sh_prefs_service.dart';
import 'app_themes/app_themes.dart';

// StateNotifierProvider для управління темою
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final sharedPrefsService =
      DIServiceLocator.instance.get<SharedPreferencesService>();
  return ThemeNotifier(sharedPrefsService);
});

// Провайдер для отримання ThemeData відповідно до ThemeMode
final themeDataProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeProvider);
  return themeMode == ThemeMode.dark
      ? ThisAppThemes.kDarkTheme
      : ThisAppThemes.kLightTheme;
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final SharedPreferencesService _sharedPreferencesService;

  ThemeNotifier(this._sharedPreferencesService) : super(ThemeMode.light) {
    loadThemeFromPreferences();
  }

  Future<void> loadThemeFromPreferences() async {
    // Отримуємо дані через сервіс
    final themeMode = _sharedPreferencesService.loadThemeMode();
    state = themeMode;
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    // Зберігаємо нову тему через сервіс
    await _sharedPreferencesService.saveThemeMode(state);
    // Можна додати додаткову логіку, наприклад, скидання кешу
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
