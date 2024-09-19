import 'package:flutter/material.dart';
import '../app_colors/app_color_schemes.dart';
import '../app_colors/app_colors.dart';
import 'themes_builder.dart';

class ThisAppThemes {
  //  Themes
  static final ThemeData kLightTheme = ThisAppThemesBuilder.buildThemeData(
    isDark: false,
    colorScheme: ThisAppColorSchemes.kLightAndroidColorScheme,
    scaffoldBackgroundColor: AppColors.kLightAndroidBackground,
    appBarBackgroundColor: ThisAppColorSchemes.kLightAndroidColorScheme.surface,
    barBackgroundColor:
        ThisAppColorSchemes.kLightAndroidColorScheme.surface.withOpacity(0.3),
    dividerColor:
        ThisAppColorSchemes.kLightAndroidColorScheme.onSurface.withOpacity(0.5),
    highlightColor: AppColors.kAppPrimaryColor.withOpacity(0.3),
    splashColor: AppColors.kAppPrimaryColor.withOpacity(0.2),
    tooltipColor: AppColors.kAppPrimaryColor.withOpacity(0.9),
    tabBarIndicatorColor: AppColors.kAppPrimaryColor,
    tabBarLabelColor: ThisAppColorSchemes.kLightAndroidColorScheme.onPrimary,
    tabBarUnselectedLabelColor:
        ThisAppColorSchemes.kLightAndroidColorScheme.onSurface,
  );

  static final ThemeData kDarkTheme = ThisAppThemesBuilder.buildThemeData(
    isDark: true,
    colorScheme: ThisAppColorSchemes.kDarkAndroidColorScheme,
    scaffoldBackgroundColor: AppColors.kDarkAndroidBackground,
    appBarBackgroundColor: ThisAppColorSchemes.kDarkAndroidColorScheme.surface,
    barBackgroundColor:
        ThisAppColorSchemes.kDarkAndroidColorScheme.surface.withOpacity(0.5),
    dividerColor:
        ThisAppColorSchemes.kDarkAndroidColorScheme.onSurface.withOpacity(0.5),
    highlightColor: AppColors.kAppPrimaryColor.withOpacity(0.3),
    splashColor: AppColors.kAppPrimaryColor.withOpacity(0.2),
    tooltipColor: AppColors.kAppPrimaryColor.withOpacity(0.9),
    tabBarIndicatorColor: AppColors.kAppPrimaryColor,
    tabBarLabelColor: ThisAppColorSchemes.kDarkAndroidColorScheme.onPrimary,
    tabBarUnselectedLabelColor:
        ThisAppColorSchemes.kDarkAndroidColorScheme.onSurface,
  );
}
