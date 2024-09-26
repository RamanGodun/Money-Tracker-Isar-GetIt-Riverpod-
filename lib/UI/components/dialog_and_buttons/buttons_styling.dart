import 'package:flutter/material.dart';
import '../../../DATA/constants/app_borders.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/helpers/helpers.dart';
import '../../themes_configuration/app_colors.dart';
import '../text_widgets.dart';

/// `AppButtonsStyling` manages the styling for different types of buttons in the app, including Elevated and Outlined buttons.
abstract class AppButtonsStyling {
  /// General method for creating a styled button (Elevated or Outlined), depending on the passed parameters.
  /// The [isElevated] flag determines the type of button.
  static Widget customButton({
    required BuildContext context,
    required String buttonText,
    required ThemeData theme,
    bool isElevated = true,
    void Function()? onPressed,
    TextStyle? textStyle,
  }) {
    final isDark = Helpers.isDarkTheme(theme);
    final colorScheme = theme.colorScheme;
    final backgroundColor = isElevated
        ? colorScheme.primary.withOpacity(isDark ? 0.85 : 0.9)
        : colorScheme.surface.withOpacity(isDark ? 0.1 : 0.05);
    final foregroundColor = colorScheme.onPrimary;

    return Material(
      color: AppColors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.heightCommon,
        child: isElevated
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  foregroundColor: foregroundColor,
                  shape:
                      AppBordersStyling.appRoundedRectangleBorder(colorScheme),
                  elevation: AppConstants.elevationCommon,
                  padding: AppConstants.paddingCommon,
                ),
                onPressed: onPressed,
                child: StyledText.forButtons(theme, buttonText, true),
              )
            : OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  side: BorderSide(
                    color: colorScheme.primary.withOpacity(0.3),
                    width: 1.0,
                  ),
                  shape:
                      AppBordersStyling.appRoundedRectangleBorder(colorScheme),
                ),
                onPressed: onPressed,
                child: Center(
                  child: StyledText.forButtons(
                    theme,
                    buttonText,
                    false,
                  ),
                ),
              ),
      ),
    );
  }

  /// Creates a primary action button using the unified method, simplifying the interface for Elevated buttons.
  static Widget primaryButton({
    required BuildContext context,
    required String buttonText,
    required ThemeData theme,
    void Function()? onPressed,
  }) {
    return customButton(
      context: context,
      buttonText: buttonText,
      theme: theme,
      isElevated: true,
      onPressed: onPressed,
    );
  }

  /// Creates a secondary, outlined button using the unified method, often used for cancel or dismiss actions.
  static Widget secondaryButton({
    required BuildContext context,
    required String buttonText,
    required ThemeData theme,
    void Function()? onPressed,
    TextStyle? textStyle,
  }) {
    return customButton(
      context: context,
      buttonText: buttonText,
      theme: theme,
      isElevated: false,
      onPressed: onPressed,
      textStyle: textStyle,
    );
  }
}
