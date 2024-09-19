import 'package:flutter/material.dart';
import '../../../data/Theme_configuration/app_colors/app_colors.dart';
import '../../../data/Theme_configuration/others/app_styling_constants.dart';
import '../../../data/providers/constants/app_borders.dart';
import '../../../data/providers/constants/app_box_decoration.dart';
import '../../../data/providers/constants/app_text_styling.dart';
import '../../../domain/app_enums.dart';
import '../../../domain/helpers/helpers.dart';
import '../dialog_buttons.dart';
import '../dividers.dart';
import '../mini_widgets.dart';

abstract class AppDialogsStyling {
  static Widget customAndroidDialogStyle({
    required BuildContext context,
    required double widthFraction,
    required double heightFraction,
    required String dialogTitle,
    required Widget contentWidget,
    required EdgeInsets contentPadding,
    required VoidCallback onActionPressed,
    required VoidCallback onCancelPressed,
    required String actionButtonText,
    required String cancelButtonText,
  }) {
    final theme = Helpers.themeGet(context);
    final colorScheme = theme.colorScheme;
    final deviceSize = Helpers.deviceSizeGet(context);
    final deviceWidth = deviceSize.width;
    final deviceHeight = deviceSize.height;

    return Stack(
      children: [
        Dialog(
          backgroundColor: AppColors.transparent,
          shape: AppBordersStyling.rectangleBorderForDialog(theme),
          child: Container(
            width: deviceWidth * widthFraction,
            height: deviceHeight * heightFraction,
            padding: AppStylingConstants.zeroPadding,
            decoration: AppBoxDecorations.forAndroidDialog(theme),
            child: Stack(
              children: [
                AppMiniWidgets.backDropFilter(
                  child: Container(
                      decoration: AppBoxDecorations.forAndroidDialog1(theme)),
                ),
                Container(
                  padding: AppStylingConstants.zeroPadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 26, left: 16, right: 16, bottom: 8),
                        child: Text(
                          dialogTitle,
                          style: AppTextStyling.appBarTitle(context, theme),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      AppDividers.divider2(theme),
                      const SizedBox(height: 7),
                      Expanded(
                        child: Padding(
                          padding: contentPadding,
                          child: contentWidget,
                        ),
                      ),
                      const SizedBox(height: 7),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: colorScheme.surface.withOpacity(0.5),
            padding: AppStylingConstants.allPadding10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppDialogsButtons.custom(
                  context: context,
                  buttonType: DialogButtonType.cancelButtonInAndroidType,
                  onPressed: onCancelPressed,
                  buttonText: cancelButtonText,
                ),
                AppDividers.dividerBetweenDialogButtons(theme),
                AppDialogsButtons.custom(
                  context: context,
                  buttonType: DialogButtonType.actionButtonInAndroidStyle,
                  onPressed: onActionPressed,
                  buttonText: actionButtonText,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
