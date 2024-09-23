import 'package:flutter/material.dart';
import '../../../DATA/Theme_configuration/app_colors/app_colors.dart';
import '../../../DATA/constants/app_styling_constants.dart';
import '../../../DATA/constants/app_borders.dart';
import '../../../DATA/constants/app_text_styling.dart';
import '../../../DATA/helpers/helpers.dart';

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
        height: AppStylingConstants.buttonsHeight,
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
            padding: AppStylingConstants.horizontal8,
            child: Text(
              buttonText,
              style: AppTextStyling.forButtons(theme),
            ),
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
        height: AppStylingConstants.buttonsHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shape: AppBordersStyling.roundedRectangleBorderForButton(theme),
            elevation: AppStylingConstants.elevation,
            padding: AppStylingConstants.commonPadding,
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: AppTextStyling.forButtons(theme),
          ),
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
    final textStyleForButton = textStyle ?? AppTextStyling.forButtons(theme);
    return Material(
      color: AppColors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: AppStylingConstants.buttonsHeight,
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
            child: Text(
              buttonText,
              style: textStyleForButton,
            ),
          ),
        ),
      ),
    );
  }
}
