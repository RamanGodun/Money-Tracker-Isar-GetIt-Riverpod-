import 'package:flutter/material.dart';

import '../../../DATA/constants/app_borders.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/helpers/helpers.dart';
import '../../themes_configuration/app_colors.dart';
import '../text_widgets.dart';

abstract class AppButtonsStyling {
  static Widget firstDesign(
    BuildContext context,
    ThemeData theme, {
    void Function()? onPressed,
    required String buttonText,
  }) {
    final isDark = Helpers.isDarkTheme(theme);
    final colorScheme = theme.colorScheme;

    return Material(
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.heightCommon,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                AppBordersStyling.appRoundedRectangleBorder(colorScheme)),
            backgroundColor: WidgetStateProperty.all(
              colorScheme.primary.withOpacity(isDark ? 0.45 : 0.7),
            ),
          ),
          onPressed: onPressed,
          child: Padding(
            padding: AppConstants.paddingHorizontal18,
            child: StyledText.forButtons(theme, buttonText, true),
          ),
        ),
      ),
    );
  }

  static Widget forElevatedButton(
    BuildContext context, {
    void Function()? onPressed,
    required String buttonText,
  }) {
    final theme = Helpers.getTheme(context);
    final isDark = Helpers.isDarkTheme(theme);
    final colorScheme = theme.colorScheme;
    final backgroundColor =
        colorScheme.primary.withOpacity(isDark ? 0.85 : 0.9);
    final foregroundColor = colorScheme.onPrimary;
    return Material(
      color: AppColors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.heightCommon,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shape: AppBordersStyling.appRoundedRectangleBorder(colorScheme),
            elevation: AppConstants.elevationCommon,
            padding: AppConstants.paddingCommon,
          ),
          onPressed: onPressed,
          child: StyledText.forButtons(theme, buttonText, true),
        ),
      ),
    );
  }

  /* Стиль для обведеної кнопки */
  static Widget forOutlinedButton(
    BuildContext context,
    ThemeData theme, {
    void Function()? onPressed,
    required String buttonText,
    TextStyle? textStyle,
  }) {
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: AppColors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.heightCommon,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor:
                theme.colorScheme.surface.withOpacity(isDark ? 0.1 : 0.05),
            side: BorderSide(
              color: theme.colorScheme.primary.withOpacity(0.3),
              width: 1.0,
            ),
            shape:
                AppBordersStyling.appRoundedRectangleBorder(theme.colorScheme),
          ),
          onPressed: onPressed,
          child: Center(
            child: StyledText.forButtons(theme, buttonText, false),
          ),
        ),
      ),
    );
  }
}
