import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class ThisAppColorSchemes {
  /*  LIGHT color Scheme */
  static final kLightAndroidColorScheme = ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: AppColors.kPrimarySwatch,
    accentColor: AppColors.kSecondaryVariant,
    backgroundColor: const Color.fromARGB(255, 255, 255, 255)
        .withOpacity(0.7), // Злегка прозорий
    errorColor: AppColors.kErrorColor,
  ).copyWith(
    primaryContainer: AppColors.kAppPrimaryColor.withOpacity(0.2),
    secondaryContainer: AppColors.kSecondaryColor.withOpacity(0.15),
    surface: const Color.fromARGB(255, 255, 254, 254).withOpacity(0.6),
    onPrimary: AppColors.kLightAndroidOnPrimary,
    onSecondary: AppColors.kLightAndroidOnPrimary,
    onSurface: AppColors.kLightAndroidOnSurface,
    onError: AppColors.kLightAndroidOnPrimary,
    // shadow: AppColors.cupertinoBlackColor.withOpacity(0.2),
  );

  /*  DARK color Scheme */
  static final kDarkAndroidColorScheme = ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: AppColors.kPrimarySwatch,
    accentColor: AppColors.kSecondaryVariant,
    backgroundColor:
        AppColors.kDarkAndroidBackground.withOpacity(0.65), // Прозорий
    errorColor: AppColors.kErrorColor,
  ).copyWith(
    primaryContainer: AppColors.kAppPrimaryColor.withOpacity(0.2),
    secondaryContainer: AppColors.kSecondaryColor.withOpacity(0.15),
    surface: AppColors.kDarkAndroidSurface.withOpacity(0.5),
    onPrimary: AppColors.kDarkAndroidOnPrimary,
    onSecondary: AppColors.kDarkAndroidOnPrimary,
    onSurface: AppColors.kDarkAndroidOnSurface,
    onError: AppColors.kDarkAndroidOnPrimary,
    error: AppColors.kErrorColor,
  );
}
