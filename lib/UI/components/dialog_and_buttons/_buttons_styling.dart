import 'package:flutter/material.dart';

import '../../../DATA/constants/app_borders.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/helpers/helpers.dart';
import '../../../DATA/themes_set/app_themes/app_colors.dart';
import '../text_widgets.dart';

abstract class AppButtonsStyling {
  static Widget firstDesign(
    BuildContext context, {
    void Function()? onPressed,
    required String buttonText,
  }) {
    final theme = Helpers.themeGet(context);
    final isDark = Helpers.isDarkTheme(theme);
    final colorScheme = theme.colorScheme;
    return Material(
      color: AppColors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.buttonsHeight,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                AppBordersStyling.roundedRectangleBorderForButton(theme)),
            backgroundColor: WidgetStateProperty.all(
              colorScheme.primary.withOpacity(isDark ? 0.45 : 0.7),
            ),
          ),
          onPressed: onPressed,
          child: Padding(
            padding: AppConstants.horizontal8,
            child: StyledText.forButtons(theme, buttonText),
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
    final theme = Helpers.themeGet(context);
    final isDark = Helpers.isDarkTheme(theme);
    final colorScheme = theme.colorScheme;
    final backgroundColor =
        colorScheme.primary.withOpacity(isDark ? 0.45 : 0.7);
    final foregroundColor = colorScheme.onPrimary;
    return Material(
      color: AppColors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.buttonsHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shape: AppBordersStyling.roundedRectangleBorderForButton(theme),
            elevation: AppConstants.elevation,
            padding: AppConstants.commonPadding,
          ),
          onPressed: onPressed,
          child: StyledText.forButtons(theme, buttonText),
        ),
      ),
    );
  }

  /* Стиль для обведеної кнопки */
  static Widget forOutlinedButton(
    BuildContext context, {
    void Function()? onPressed,
    required String buttonText,
    TextStyle? textStyle,
  }) {
    final theme = Helpers.themeGet(context);
    final isDark = Helpers.isDarkTheme(theme);

    return Material(
      color: AppColors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.buttonsHeight,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor:
                theme.colorScheme.surface.withOpacity(isDark ? 0.1 : 0.01),
            side: BorderSide(
              color: theme.colorScheme.primary.withOpacity(0.3),
              width: 1.0,
            ),
            shape: AppBordersStyling.roundedRectangleBorderForButton(theme),
          ),
          onPressed: onPressed,
          child: Center(
            child: StyledText.forButtons(theme, buttonText),
          ),
        ),
      ),
    );
  }
}
