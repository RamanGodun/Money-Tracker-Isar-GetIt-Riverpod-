import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../DATA/helpers/helpers.dart';

/// Provides text styles for the app based on the Google Montserrat font.
/// Supports both light and dark themes.
abstract class AppTextStyles {
  /// Returns a custom TextTheme based on the Montserrat font.
  /// Adjusts the styles depending on the current theme (light or dark).
  static TextTheme kTextThemeData(bool isDarkTheme, ColorScheme colorScheme) {
    return GoogleFonts.montserratTextTheme().copyWith(
      titleLarge: _getTextStyle(isDarkTheme, colorScheme, FontWeight.w700, 22),
      titleMedium: _getTextStyle(isDarkTheme, colorScheme, FontWeight.w600, 20),
      titleSmall: _getTextStyle(isDarkTheme, colorScheme, FontWeight.w500, 18),
      bodyLarge: _getTextStyle(isDarkTheme, colorScheme, FontWeight.w400, 16),
      bodyMedium: _getTextStyle(isDarkTheme, colorScheme, FontWeight.w400, 14),
      bodySmall: _getTextStyle(isDarkTheme, colorScheme, FontWeight.w300, 12),
      labelLarge: _getTextStyle(isDarkTheme, colorScheme, FontWeight.w600, 14),
      labelMedium: _getTextStyle(isDarkTheme, colorScheme, FontWeight.w500, 12),
      labelSmall: _getTextStyle(isDarkTheme, colorScheme, FontWeight.w400, 11),
      displayLarge:
          _getTextStyle(isDarkTheme, colorScheme, FontWeight.w800, 30),
      displayMedium:
          _getTextStyle(isDarkTheme, colorScheme, FontWeight.w700, 26),
      displaySmall:
          _getTextStyle(isDarkTheme, colorScheme, FontWeight.w600, 22),
    );
  }

  /// Returns a custom TextStyle based on the specified parameters.
  static TextStyle _getTextStyle(bool isDarkTheme, ColorScheme colorScheme,
      FontWeight fontWeight, double fontSize) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: isDarkTheme ? colorScheme.onSurface : colorScheme.onSurface,
      letterSpacing: 0.5,
      height: 1.3,
    );
  }

  /// Provides Cupertino-style text theme based on the current context.
  static CupertinoTextThemeData getCupertinoTextStyle(BuildContext context) {
    final colorScheme = Helpers.getColorScheme(context);
    return CupertinoTextThemeData(
      primaryColor: colorScheme.onSurface,
      navTitleTextStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
