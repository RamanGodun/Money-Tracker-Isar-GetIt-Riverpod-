import 'package:flutter/material.dart';
import 'app_constants.dart';
import '../helpers/helpers.dart';
import '../themes_set/app_themes/app_colors.dart';

abstract class AppBordersStyling {
  static Border forBoxDecoration(ThemeData theme) {
    final isDarkMode = Helpers.isDarkTheme(theme);
    return Border.all(
      color: isDarkMode
          ? AppColors.cupertinoBlackColor.withOpacity(0.15)
          : theme.colorScheme.shadow.withOpacity(0.05),
      width: 0.2,
    );
  }

  static RoundedRectangleBorder roundedRectangleBorder(ThemeData theme) {
    return RoundedRectangleBorder(
      borderRadius: AppConstants.commonBorderRadius,
      side: BorderSide(color: theme.colorScheme.primary.withOpacity(0.1)),
    );
  }

  static ShapeBorder rectangleBorder(ThemeData theme,
      {BorderRadius? borderRadius}) {
    return RoundedRectangleBorder(
      borderRadius: borderRadius ?? AppConstants.radius12,
      side: BorderSide(
        color: theme.colorScheme.shadow.withOpacity(0.05),
      ),
    );
  }

  // Новий метод для повернення OutlineInputBorder
  static OutlineInputBorder inputFieldBorder(ThemeData theme) {
    return OutlineInputBorder(
      borderRadius: AppConstants.radius12,
      borderSide: BorderSide(
        color: theme.colorScheme.primary.withOpacity(0.3),
      ),
    );
  }
}
