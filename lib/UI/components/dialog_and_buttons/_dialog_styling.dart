import 'package:flutter/material.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/constants/app_borders.dart';
import '../../../DATA/constants/app_box_decoration.dart';
import '../../../DATA/helpers/helpers.dart';
import '../../../DATA/themes_set/app_themes/app_colors.dart';
import '../../../DOMAIN/models/app_enums.dart';
import 'dialog_buttons.dart';
import '../other_widgets.dart';

abstract class AppDialogsStyling {
/*
 NEED TO ADD  customIOSDialogStyle 
 */

  static Widget customAndroidDialogStyle({
    required BuildContext context,
    required Widget contentWidget,
    required EdgeInsets contentPadding,
    required VoidCallback onActionPressed,
    onCancelPressed,
    required String actionButtonText,
    cancelButtonText,
    dialogTitle,
  }) {
    final theme = Helpers.themeGet(context);
    final deviceSize = Helpers.deviceSizeGet(context);

    final isPortraitMode = (deviceSize.width < 600);
    final widthFraction = isPortraitMode ? 0.77 : 0.85;
    final width = widthFraction * deviceSize.width;
    final heightFraction = isPortraitMode ? 0.6 : 0.9;
    final height = heightFraction * deviceSize.height;

    return Stack(
      children: [
        Dialog(
          backgroundColor: AppColors.transparent,
          shape: AppBordersStyling.rectangleBorder(theme),
          child: Container(
            width: width,
            height: height,
            padding: AppConstants.zeroPadding,
            decoration: AppBoxDecorations.inGlassMorphismStyle(theme),
            child: Stack(
              children: [
                AppBoxDecorations.withBlurEffect(
                  blur: 10,
                  child: Container(
                      decoration:
                          AppBoxDecorations.inGlassMorphismStyle(theme)),
                ),
                Container(
                  padding: AppConstants.zeroPadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 26, left: 16, right: 16, bottom: 8),
                        child: Text(
                          dialogTitle,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      AppMiniWidgets.divider(theme),
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
          bottom: isPortraitMode ? 30 : 0,
          left: 0,
          right: 0,
          child: Container(
            padding: AppConstants.allPadding10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppDialogsButtons.custom(
                  context: context,
                  buttonType: DialogButtonType.cancelButtonInAndroidType,
                  onPressed: onCancelPressed,
                  buttonText: cancelButtonText,
                ),
                AppMiniWidgets.dividerBetweenDialogButtons(theme),
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
