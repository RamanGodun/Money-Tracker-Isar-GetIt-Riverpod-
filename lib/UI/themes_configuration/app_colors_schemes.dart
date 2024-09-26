import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Defines light and dark color schemes for the app.
abstract class AppColorSchemes {
  /* LIGHT color scheme configuration */
  static final kLightAndroidColorScheme = ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: AppColors.primarySwatch,
    accentColor: AppColors.secondaryVariant,
    backgroundColor: const Color.fromARGB(255, 255, 255, 255)
        .withOpacity(0.7), // Slightly transparent background
    errorColor: AppColors.errorColor,
  ).copyWith(
    primaryContainer: AppColors.appPrimaryColor.withOpacity(0.2),
    secondaryContainer: AppColors.secondaryColor.withOpacity(0.15),
    surface: const Color.fromARGB(255, 255, 254, 254).withOpacity(0.6),
    onPrimary: AppColors.lightOnPrimary,
    onSecondary: AppColors.lightOnPrimary,
    onSurface: AppColors.lightOnSurface,
    onError: AppColors.lightOnPrimary,
  );

  /* DARK color scheme configuration */
  static final kDarkAndroidColorScheme = ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: AppColors.primarySwatch,
    accentColor: AppColors.secondaryVariant,
    backgroundColor:
        AppColors.darkBackground.withOpacity(0.65), // Transparent background
    errorColor: AppColors.errorColor,
  ).copyWith(
    primaryContainer: AppColors.appPrimaryColor.withOpacity(0.2),
    secondaryContainer: AppColors.secondaryColor.withOpacity(0.15),
    surface: AppColors.darkSurface.withOpacity(0.5),
    onPrimary: AppColors.darkOnPrimary,
    onSecondary: AppColors.darkOnPrimary,
    onSurface: AppColors.darkOnSurface,
    onError: AppColors.darkOnPrimary,
    error: AppColors.errorColor,
  );
}

/* 
Naming recommendations:
1. `ThisAppColorSchemes` — Could be simplified to `AppColorSchemes` for clarity.
*/
