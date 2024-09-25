import 'package:flutter/material.dart';
import 'app_constants.dart';
import '../helpers/helpers.dart';
import '../themes_set/app_themes/app_colors.dart';

abstract class AppBordersStyling {
  static Border appBorder(ThemeData theme) {
    final isDarkMode = Helpers.isDarkTheme(theme);
    return Border.all(
      color: isDarkMode
          ? AppColors.cupertinoBlackColor.withOpacity(0.15)
          : theme.colorScheme.shadow.withOpacity(0.05),
      width: 0.2,
    );
  }

  static RoundedRectangleBorder appRoundedRectangleBorder(
      ColorScheme colorScheme) {
    return RoundedRectangleBorder(
      borderRadius: AppConstants.borderRadiusCommon,
      side: BorderSide(color: colorScheme.primary.withOpacity(0.1)),
    );
  }

  static ShapeBorder appShapeBorder(ColorScheme colorScheme,
      {BorderRadius? borderRadius}) {
    return RoundedRectangleBorder(
      borderRadius: borderRadius ?? AppConstants.borderRadiusCommon,
      side: BorderSide(
        color: colorScheme.shadow.withOpacity(0.05),
      ),
    );
  }

  // Новий метод для повернення OutlineInputBorder
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
