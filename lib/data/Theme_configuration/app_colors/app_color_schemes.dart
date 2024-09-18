import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class ThisAppColorSchemes {
  /*  LIGHT color Scheme */
  static final kLightAndroidColorScheme = ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: AppColors.kPrimarySwatch,
    accentColor: AppColors.kSecondaryVariant,
    backgroundColor: AppColors.kLightAndroidBackground,
    errorColor: AppColors.kErrorColor,
  ).copyWith(
    primaryContainer: AppColors.kAppPrimaryColor.withOpacity(0.2),
    secondaryContainer: AppColors.kSecondaryColor.withOpacity(0.2),
    surface: AppColors.kLightAndroidSurface,
    onPrimary: AppColors.kLightAndroidOnPrimary,
    onSecondary: AppColors.kLightAndroidOnPrimary,
    onSurface: AppColors.kLightAndroidOnSurface,
    onError: AppColors.kLightAndroidOnPrimary,
  );

  /*  DARK color Scheme */
  static final kDarkAndroidColorScheme = ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: AppColors.kPrimarySwatch,
    accentColor: AppColors.kSecondaryVariant,
    backgroundColor: AppColors.kDarkAndroidBackground,
    errorColor: AppColors.kErrorColor,
  ).copyWith(
    primaryContainer: AppColors.kAppPrimaryColor.withOpacity(0.2),
    secondaryContainer: AppColors.kSecondaryColor.withOpacity(0.2),
    surface: AppColors.kDarkAndroidSurface,
    onPrimary: AppColors.kDarkAndroidOnPrimary,
    onSecondary: AppColors.kDarkAndroidOnPrimary,
    onSurface: AppColors.kDarkAndroidOnSurface,
    onError: AppColors.kDarkAndroidOnPrimary,
    error: AppColors.kErrorColor,
  );
}
