import 'package:flutter/material.dart';
import '../../data/Theme_configuration/app_colors/app_colors.dart';
import '../../data/Theme_configuration/others/app_styling_constants.dart';
import '../../data/providers/constants/strings_4_app.dart';
import '../../data/helpers/helpers.dart';

class AppDividers {
/* Custom Dividers
 */
  static Widget divider(
    bool isDarkMode, {
    bool? isSymmetric,
  }) {
    bool isWithSymmetry = isSymmetric ?? true;
    return Padding(
      padding: isWithSymmetry
          ? AppStylingConstants.zeroPadding
          : AppStylingConstants.forDivider,
      child: Divider(
        color: isDarkMode
            ? AppColors.kSecondaryDarkColor
            : AppColors.kSecondaryColor,
        thickness: isDarkMode ? 0.09 : 0.07,
        height: 0.01,
      ),
    );
  }

  static Widget divider2(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final isDarkMode = Helpers.isDarkTheme(theme);
    return Divider(
      thickness: 0.5,
      color: colorScheme.inverseSurface.withOpacity(isDarkMode ? 1 : 0.5),
    );
  }

/* BOLD Dividers
 */
  static Widget boldDivider(ThemeData theme) {
    final isDarkMode = Helpers.isDarkTheme(theme);
    return Padding(
      padding: AppStylingConstants.forBoldDivider,
      child: Divider(
        color: isDarkMode
            ? AppColors.kSecondaryDarkColor
            : AppColors.kSecondaryColor,
        thickness: isDarkMode ? 0.09 : 0.1,
        height: 1,
      ),
    );
  }

/*
  DIVIDER 4 Sign page
 */
  static Widget dividerForSignPage(ThemeData theme) {
    // final isDarkMode = Helpers.isDarkTheme(theme);
    return Material(
      color: AppColors.transparent,
      child: SizedBox(
        height: 40,
        child: Column(children: [
          Row(
            children: <Widget>[
              Expanded(child: AppDividers.divider2(theme)),
              Padding(
                padding: AppStylingConstants.horizontal8,
                child: Text(
                  AppStrings.continueWith,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(child: AppDividers.divider2(theme)),
            ],
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

/*
DIVIDER for CUSTOM DIALOG 
 */
  static Widget dividerForCustomDialog(ThemeData theme) {
    return Divider(
      height: 0.4,
      thickness: 0.7,
      color: theme.colorScheme.inverseSurface.withOpacity(0.5),
    );
  }

  static Widget dividerBetweenDialogButtons(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    return Container(
      width: 0.5,
      color: colorScheme.inverseSurface.withOpacity(0.5),
    );
  }

  static Widget getDividerBetweenDialogButtons(ThemeData theme) =>
      dividerBetweenDialogButtons(theme);
//
}
