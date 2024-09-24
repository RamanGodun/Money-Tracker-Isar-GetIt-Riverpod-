import 'package:flutter/material.dart';
import 'app_styling_constants.dart';
import '../helpers/helpers.dart';
import '../themes_set/app_themes/app_colors.dart';

abstract class AppBordersStyling {
  static Border forAndroidBoxDecoration(ThemeData theme) {
    final isDarkMode = Helpers.isDarkTheme(theme);
    return Border.all(
      color: isDarkMode
          ? AppColors.cupertinoBlackColor.withOpacity(0.15)
          : theme.colorScheme.inverseSurface.withOpacity(0.05),
      width: 0.2,
    );
  }

  static RoundedRectangleBorder roundedRectangleBorderForButton(
      ThemeData theme) {
    return RoundedRectangleBorder(
      borderRadius: AppConstants.commonBorderRadius,
      side: BorderSide(color: theme.colorScheme.primary.withOpacity(0.1)),
    );
  }

  static ShapeBorder rectangleBorderForDialog(ThemeData theme,
      {BorderRadius? borderRadius}) {
    return RoundedRectangleBorder(
      borderRadius: borderRadius ?? AppConstants.radius12,
      side: BorderSide(
        color: theme.colorScheme.onSurface.withOpacity(0.05),
      ),
    );
  }
}
