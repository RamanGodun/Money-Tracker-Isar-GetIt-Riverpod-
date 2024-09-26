import 'package:flutter/material.dart';
import 'app_colors_schemes.dart';
import 'app_colors.dart';
import 'app_themes_builder.dart';

/// This class holds the predefined theme configurations for light and dark modes.
/// These themes are built using the `ThisAppThemesBuilder` utility.
class AppThemes {
  /// Light theme configuration for the application.
  static final ThemeData lightTheme = ThisAppThemesBuilder.buildThemeData(
    isDark: false,
    colorScheme: AppColorSchemes.kLightAndroidColorScheme,
    scaffoldBackgroundColor:
        AppColors.glassBackgroundLight, // Translucent background
    appBarBackgroundColor: AppColors.glassSurfaceLight,
    barBackgroundColor: AppColors.glassSurfaceLight.withOpacity(0.2),
    dividerColor: AppColors.glassSurfaceLight.withOpacity(0.4),
    highlightColor: AppColors.appPrimaryColor.withOpacity(0.3),
    splashColor: AppColors.appPrimaryColor.withOpacity(0.2),
    tooltipColor: AppColors.appPrimaryColor.withOpacity(0.9),
    tabBarIndicatorColor: AppColors.appPrimaryColor,
    tabBarLabelColor: AppColors.lightSurface,
    tabBarUnselectedLabelColor: AppColors.lightOnSurface,
  );

  /// Dark theme configuration for the application.
  static final ThemeData darkTheme = ThisAppThemesBuilder.buildThemeData(
    isDark: true,
    colorScheme: AppColorSchemes.kDarkAndroidColorScheme,
    scaffoldBackgroundColor: AppColors.glassBackgroundDark,
    appBarBackgroundColor: AppColors.glassSurfaceDark,
    barBackgroundColor: AppColors.glassSurfaceDark.withOpacity(0.2),
    dividerColor: AppColors.glassSurfaceDark.withOpacity(0.4),
    highlightColor: AppColors.appPrimaryColor.withOpacity(0.3),
    splashColor: AppColors.appPrimaryColor.withOpacity(0.2),
    tooltipColor: AppColors.appPrimaryColor.withOpacity(0.9),
    tabBarIndicatorColor: AppColors.appPrimaryColor,
    tabBarLabelColor: AppColors.darkOnPrimary,
    tabBarUnselectedLabelColor: AppColors.darkOnSurface,
  );
}
