import 'package:flutter/cupertino.dart';
import '../../../data/constants/app_text_styling.dart';
import '../../../DOMAIN/models/app_enums.dart';
import '../../../DATA/helpers/helpers.dart';
import '_buttons_styling.dart';

class AppDialogsButtons {
  static Widget custom({
    required BuildContext context,
    required DialogButtonType? buttonType,
    VoidCallback? onPressed,
    required String buttonText, // Текст кнопки
  }) {
    switch (buttonType) {
      case DialogButtonType.actionButtonInAndroidStyle:
        return _buildMaterialDialogAction(
          context: context,
          isActionButton: true,
          onPressed: onPressed,
          buttonText: buttonText,
        );
      case DialogButtonType.cancelButtonInAndroidType:
        return _buildMaterialDialogAction(
          context: context,
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
    required String buttonText,
    FontWeight fontWeight = FontWeight.w700,
    required VoidCallback? onPressed,
    required bool isActionButton,
  }) {
    final theme = Helpers.themeGet(context);
    final deviceWidth = Helpers.deviceWidthGet(context);
    return SizedBox(
      width: deviceWidth * 0.4,
      child: isActionButton
          ? AppButtonsStyling.firstDesign(
              context,
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              buttonText: buttonText,
            )
          : AppButtonsStyling.forOutlinedButton(
              context,
              textStyle: AppTextStyling.forButtons(theme).copyWith(
                  color: theme.colorScheme.error, fontWeight: fontWeight),
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              buttonText: buttonText,
            ),
    );
  }
}
