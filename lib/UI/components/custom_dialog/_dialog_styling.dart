import 'package:flutter/material.dart';
import '../../../DATA/themes_set/app_themes/app_colors.dart';
import '../../../DATA/constants/app_box_decoration.dart';
import '../../../data/constants/app_styling_constants.dart';
import '../../../data/constants/app_borders.dart';
import '../../../DOMAIN/models/app_enums.dart';
import '../../../DATA/helpers/helpers.dart';
import '../buttons/dialog_buttons.dart';
import '../mini_widgets.dart';

abstract class AppDialogsStyling {
  static Widget customAndroidDialogStyle({
    required BuildContext context,
    required double widthFraction,
    required double heightFraction,
    required Widget contentWidget,
    required EdgeInsets contentPadding,
    required VoidCallback onActionPressed,
    required VoidCallback onCancelPressed,
    required String actionButtonText,
    required String cancelButtonText,
    required String dialogTitle,
  }) {
    final theme = Helpers.themeGet(context);
    // final colorScheme = theme.colorScheme;
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
            padding: AppConstants.zeroPadding,
            decoration: AppBoxDecorations.withShadows(theme),
            child: Stack(
              children: [
                AppMiniWidgets.backDropFilter(
                  child: Container(
                      decoration: AppBoxDecorations.withShadows(theme)),
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
          bottom: 30,
          left: 0,
          right: 0,
          child: Container(
            // color: colorScheme.shadow.withOpacity(0.15),
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
