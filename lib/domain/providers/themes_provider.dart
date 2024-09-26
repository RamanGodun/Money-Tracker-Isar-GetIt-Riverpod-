import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Services/_service_locator.dart';
import '../../DATA/data_services/sh_prefs_service.dart';
import '../../UI/themes_configuration/app_themes.dart';

/// `StateNotifierProvider` responsible for managing the app's theme mode (light or dark).
///
/// This provider relies on the [SharedPreferencesService] to persist the user's theme
/// preferences and uses the [ThemeNotifier] to manage and update the theme state.
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final sharedPrefsService =
      AppServiceLocator.instance.get<SharedPreferencesService>();
  return ThemeNotifier(sharedPrefsService);
});

/// Provider that supplies the `ThemeData` object based on the current `ThemeMode`.
///
/// It watches the [themeProvider] and returns the appropriate theme configuration,
/// either dark or light, using the custom themes defined in [AppThemes].
final themeDataProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeProvider);
  return themeMode == ThemeMode.dark
      ? AppThemes.darkTheme
      : AppThemes.lightTheme;
});

/// `StateNotifier` class responsible for managing the theme state of the app.
///
/// This class interacts with [SharedPreferencesService] to save and load the user's theme
/// preferences, allowing the app to persist the chosen theme (light or dark) across sessions.
class ThemeNotifier extends StateNotifier<ThemeMode> {
  final SharedPreferencesService _sharedPreferencesService;

  /// Initializes the `ThemeNotifier` with the default light theme, then attempts
  /// to load the user's saved theme preference from shared preferences.
  ThemeNotifier(this._sharedPreferencesService) : super(ThemeMode.light) {
    loadThemeFromPreferences();
  }

  /// Loads the saved theme mode from shared preferences and updates the app's theme.
  ///
  /// This method retrieves the saved theme mode (either light or dark) and sets the
  /// corresponding state. If no saved preference is found, it defaults to light mode.
  Future<void> loadThemeFromPreferences() async {
    final themeMode = _sharedPreferencesService.loadThemeMode();
    state = themeMode;
  }

  /// Toggles the theme mode between dark and light, updates the state, and saves the new setting.
  ///
  /// This method is called when the user changes the theme. It updates the app's state
  /// and saves the user's preference using [SharedPreferencesService] for future sessions.
  Future<void> toggleTheme(bool isDarkMode) async {
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    await _sharedPreferencesService.saveThemeMode(state);
  }
}
