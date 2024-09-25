import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'text_styles.dart';

abstract class ThisAppThemesBuilder {
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
      primarySwatch: AppColors.kPrimarySwatch,
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
        errorStyle: TextStyle(color: colorScheme.error),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      // Стилізація для DropdownMenu у стилі гласморфізму
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          fillColor: colorScheme.surface.withOpacity(isDark ? 0.15 : 0.25),
          filled: true,
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: colorScheme.onSurface.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(
            colorScheme.surface.withOpacity(isDark ? 0.2 : 0.5),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          shadowColor: WidgetStateProperty.all(
            colorScheme.shadow.withOpacity(0.1),
          ),
          elevation: WidgetStateProperty.all(5),
        ),
      ),
      // Стилізація для DatePicker у стилі гласморфізму
      datePickerTheme: DatePickerThemeData(
        backgroundColor: colorScheme.surface.withOpacity(isDark ? 0.15 : 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        dayStyle: TextStyle(color: colorScheme.onSurface),
        todayBorder: BorderSide(color: colorScheme.primary),
        headerBackgroundColor: colorScheme.primary,
        headerForegroundColor: colorScheme.onPrimary,
      ),

      // Стилізація для DialogTheme у стилі гласморфізму
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surface.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 10,
        titleTextStyle: TextStyles4ThisAppThemes.kTextThemeData(isDark)
            .titleMedium
            ?.copyWith(
              color: colorScheme.onSurface,
            ),
        contentTextStyle:
            TextStyles4ThisAppThemes.kTextThemeData(isDark).bodyMedium,
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
