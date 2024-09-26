import 'package:flutter/material.dart';
import 'app_constants.dart';
import '../helpers/helpers.dart';
import '../../UI/themes_configuration/app_colors.dart';

/// A class to manage borders and shapes throughout the app.
/// Centralized border styles improve consistency and make it easier to change later.
abstract class AppBordersStyling {
  /// Common border for components
  static Border appBorder(ThemeData theme) {
    final isDarkMode = Helpers.isDarkTheme(theme);
    return Border.all(
      color: isDarkMode
          ? AppColors.cupertinoBlackColor.withOpacity(0.15)
          : theme.colorScheme.shadow.withOpacity(0.05),
      width: 0.2,
    );
  }

  /// Rounded border for components
  static RoundedRectangleBorder appRoundedRectangleBorder(
      ColorScheme colorScheme) {
    return RoundedRectangleBorder(
      borderRadius: AppConstants.borderRadiusCommon,
      side: BorderSide(color: colorScheme.primary.withOpacity(0.1)),
    );
  }

  /// Shape border for components, customizable with border radius
  static ShapeBorder appShapeBorder(ColorScheme colorScheme,
      {BorderRadius? borderRadius}) {
    return RoundedRectangleBorder(
      borderRadius: borderRadius ?? AppConstants.borderRadiusCommon,
      side: BorderSide(
        color: colorScheme.shadow.withOpacity(0.05),
      ),
    );
  }

  /// Outline border for text fields
  static OutlineInputBorder appOutlineInputBorder(ColorScheme colorScheme) {
    return OutlineInputBorder(
      borderRadius: AppConstants.borderRadiusCommon,
      borderSide: BorderSide(
        color: colorScheme.primary,
        width: 1.0,
      ),
    );
  }
}
