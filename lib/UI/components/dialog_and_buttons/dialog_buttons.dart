import 'package:flutter/material.dart';
import '../../../DATA/models/app_enums.dart';
import '../../../DATA/helpers/helpers.dart';
import 'buttons_styling.dart';

/// `AppDialogsButtons` is responsible for rendering custom dialog buttons
/// with styles tailored for different dialog button types (e.g., action button, cancel button).
class AppDialogsButtons {
  /// Creates a custom dialog button based on the provided `DialogButtonType`.
  /// This method switches between action buttons (for confirmation) and cancel buttons.
  static Widget custom(
    ThemeData theme, {
    required BuildContext context,
    required DialogButtonType? buttonType,
    VoidCallback? onPressed,
    required String buttonText,
  }) {
    switch (buttonType) {
      case DialogButtonType.actionButtonInAndroidStyle:
        return _buildMaterialDialogAction(
          context: context,
          theme: theme,
          isActionButton: true,
          onPressed: onPressed,
          buttonText: buttonText,
        );
      case DialogButtonType.cancelButtonInAndroidType:
        return _buildMaterialDialogAction(
          context: context,
          theme: theme,
          isActionButton: false,
          fontWeight: FontWeight.normal,
          onPressed: onPressed,
          buttonText: buttonText,
        );
      default:
        return const SizedBox.shrink(); //empty widget if no type is provided
    }
  }

  /// Builds a Material-style dialog button with custom styling.
  /// The button adapts its size based on screen orientation and applies
  /// specific styles for action and cancel buttons.
  static Widget _buildMaterialDialogAction({
    required BuildContext context,
    required ThemeData theme,
    required String buttonText,
    FontWeight fontWeight = FontWeight.w700,
    required VoidCallback? onPressed,
    required bool isActionButton,
  }) {
    final deviceWidth = Helpers.getDeviceWidth(context);
    final isPortraitMode = deviceWidth < 600;

    // Return a styled button with different designs for action and cancel buttons
    return SizedBox(
        width: deviceWidth * (isPortraitMode ? 0.43 : 0.31),
        child: isActionButton
            ? AppButtonsStyling.primaryButton(
                context: context,
                buttonText: buttonText,
                theme: theme,
                onPressed: onPressed ?? () => Navigator.of(context).pop(),
              )
            : AppButtonsStyling.secondaryButton(
                context: context,
                buttonText: buttonText,
                theme: theme,
                onPressed: onPressed ?? () => Navigator.of(context).pop(),
              ));
  }
}
