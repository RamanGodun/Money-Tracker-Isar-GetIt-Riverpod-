import 'package:flutter/material.dart';
import 'app_colors_schemes.dart';
import 'app_colors.dart';
import 'app_themes_builder.dart';

class ThisAppThemes {
  static final ThemeData kLightTheme = ThisAppThemesBuilder.buildThemeData(
    isDark: false,
    colorScheme: ThisAppColorSchemes.kLightAndroidColorScheme,
    scaffoldBackgroundColor: AppColors.glassBackgroundLight, // Прозорий фон
    appBarBackgroundColor: AppColors.glassSurfaceLight,
    barBackgroundColor: AppColors.glassSurfaceLight.withOpacity(0.2),
    dividerColor: AppColors.glassSurfaceLight.withOpacity(0.4),
    highlightColor: AppColors.kAppPrimaryColor.withOpacity(0.3),
    splashColor: AppColors.kAppPrimaryColor.withOpacity(0.2),
    tooltipColor: AppColors.kAppPrimaryColor.withOpacity(0.9),
    tabBarIndicatorColor: AppColors.kAppPrimaryColor,
    tabBarLabelColor: AppColors.kLightAndroidSurface,
    tabBarUnselectedLabelColor: AppColors.kLightAndroidOnSurface,
  );

  static final ThemeData kDarkTheme = ThisAppThemesBuilder.buildThemeData(
    isDark: true,
    colorScheme: ThisAppColorSchemes.kDarkAndroidColorScheme,
    scaffoldBackgroundColor: AppColors.glassBackgroundDark,
    appBarBackgroundColor: AppColors.glassSurfaceDark,
    barBackgroundColor: AppColors.glassSurfaceDark.withOpacity(0.2),
    dividerColor: AppColors.glassSurfaceDark.withOpacity(0.4),
    highlightColor: AppColors.kAppPrimaryColor.withOpacity(0.3),
    splashColor: AppColors.kAppPrimaryColor.withOpacity(0.2),
    tooltipColor: AppColors.kAppPrimaryColor.withOpacity(0.9),
    tabBarIndicatorColor: AppColors.kAppPrimaryColor,
    tabBarLabelColor: AppColors.kDarkAndroidOnPrimary,
    tabBarUnselectedLabelColor: AppColors.kDarkAndroidOnSurface,
  );
}
