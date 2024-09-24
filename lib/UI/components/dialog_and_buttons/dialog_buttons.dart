import 'package:flutter/material.dart';
import '../../../DATA/constants/app_text_styling.dart';
import '../../../DOMAIN/models/app_enums.dart';
import '../../../DATA/helpers/helpers.dart';
import '_buttons_styling.dart';

class AppDialogsButtons {
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
        return const SizedBox.shrink();
    }
  }

  static Widget _buildMaterialDialogAction({
    required BuildContext context,
    required ThemeData theme,
    required String buttonText,
    FontWeight fontWeight = FontWeight.w700,
    required VoidCallback? onPressed,
    required bool isActionButton,
  }) {
    final deviceWidth = Helpers.deviceWidthGet(context);
    return SizedBox(
      width: deviceWidth * 0.4,
      child: isActionButton
          ? AppButtonsStyling.firstDesign(
              context,
              theme,
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              buttonText: buttonText,
            )
          : AppButtonsStyling.forOutlinedButton(
              context,
              theme,
              textStyle: TextStyling.forButtons(theme, false).copyWith(
                  color: theme.colorScheme.error, fontWeight: fontWeight),
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              buttonText: buttonText,
            ),
    );
  }
}
