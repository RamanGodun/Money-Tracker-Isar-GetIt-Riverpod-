import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// AppColors defines a set of standard colors for both light and dark themes in the app.
/// It includes primary, secondary, and error colors, along with transparent layers
/// and colors used for specific UI elements like surfaces and backgrounds.
abstract class AppColors {
  /// Primary color for the app, used across all themes.
  static const Color appPrimaryColor = Color.fromARGB(255, 183, 102, 223);

  /// Creates a MaterialColor from a single color for use in Flutter's Material design system.
  static final MaterialColor primarySwatch =
      createMaterialColor(appPrimaryColor);

  /// Generates a MaterialColor from a base color, creating different shades of that color.
  /// This is useful for defining the primary swatch in a Flutter app.
  static MaterialColor createMaterialColor(Color color) {
    List<double> strengths = <double>[
      .05
    ]; // Different intensity levels of the color
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i); // Generate strengths from 0.1 to 0.9
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  /// Secondary color used in various parts of the app for less prominent elements.
  static const Color secondaryColor = Color.fromARGB(255, 95, 147, 173);

  /// Darker version of the secondary color for use in dark theme.
  static const Color secondaryDarkColor = Color.fromARGB(255, 112, 172, 201);

  /// A variant of the secondary color for subtle UI elements or highlights.
  static const Color secondaryVariant = Color.fromARGB(255, 91, 137, 159);

  /// Standard error color used for highlighting errors in the UI.
  static const Color errorColor = CupertinoColors.destructiveRed;

  /// Darker error color for use in dark theme modes.
  static const Color errorDarkColor = Color.fromARGB(255, 231, 122, 122);

  /// Background color for the light theme.
  static const Color lightBackground = Color.fromARGB(255, 255, 255, 255);

  /// Background color for the dark theme.
  static const Color darkBackground = Color(0xFF121212);

  /// Surface color for components like cards or modals in the light theme.
  static const Color lightSurface = Color.fromARGB(255, 254, 249, 249);

  /// Surface color for components in the dark theme.
  static const Color darkSurface = Color(0xFF1F1F1F);

  /// Color for text or icons displayed on surfaces in the light theme.
  static const Color lightOnSurface = Color(0xFF000000);

  /// Color for text or icons displayed on surfaces in the dark theme.
  static const Color darkOnSurface = Color(0xFFFFFFFF);

  /// Color for text or icons displayed on primary elements (e.g., AppBar) in the dark theme.
  static const Color darkOnPrimary = Color(0xFFFFFFFF);

  /// Color for text or icons displayed on primary elements in the light theme.
  static const Color lightOnPrimary = Color(0xFFFFFFFF);

  /// Cupertino-style black color, used in iOS-specific UI components.
  static const Color cupertinoBlackColor = CupertinoColors.black;

  /// Glassmorphism-style background for the light theme, used for transparent elements.
  static Color glassBackgroundLight = const Color(0xFFF4F4F4).withOpacity(0.9);

  /// Glassmorphism-style background for the dark theme.
  static Color glassBackgroundDark = const Color(0xFF2C2C2C).withOpacity(0.5);

  /// Glassmorphism-style surface color for the light theme.
  static Color glassSurfaceLight = const Color(0xFFFFFFFF).withOpacity(0.7);

  /// Glassmorphism-style surface color for the dark theme.
  static Color glassSurfaceDark = const Color(0xFF1F1F1F).withOpacity(0.6);

  /// Transparent color constant, used when full transparency is needed.
  static const Color transparent = Colors.transparent;
}
