import 'package:flutter/material.dart';
import 'text_styles.dart';

class ThisAppThemesBuilder {
  static ThemeData buildThemeData({
    required bool isDark,
    required ColorScheme colorScheme,
    required Color scaffoldBackgroundColor,
    required Color appBarBackgroundColor,
    required Color barBackgroundColor,
    required Color dividerColor,
    required Color highlightColor,
    required Color splashColor,
    required Color tooltipColor,
    required Color tabBarIndicatorColor,
    required Color tabBarLabelColor,
    required Color tabBarUnselectedLabelColor,
  }) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // primarySwatch: AppColors.kPrimarySwatch,
      colorScheme: colorScheme,
      textTheme: TextStyles4ThisAppThemes.kTextThemeData(isDark),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: TextStyles4ThisAppThemes.kTextThemeData(isDark).labelLarge,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: colorScheme.primary),
        titleTextStyle:
            TextStyles4ThisAppThemes.kTextThemeData(isDark).titleSmall,
        toolbarTextStyle: TextStyles4ThisAppThemes.kTextThemeData(isDark)
            .bodyMedium
            ?.copyWith(color: colorScheme.onSurface),
        color: scaffoldBackgroundColor.withOpacity(0.25),
      ),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.5),
          fontStyle: FontStyle.italic,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.3),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: colorScheme.surface.withOpacity(0.15),
      ),

      cardTheme: CardTheme(
        color: isDark
            ? colorScheme.inverseSurface.withOpacity(0.2)
            : colorScheme.surface.withOpacity(0.5),
        shadowColor: colorScheme.shadow.withOpacity(0.6),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
