import 'package:flutter/material.dart';
import '../other_widgets.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/constants/app_borders.dart';
import '../../../DATA/constants/app_box_decoration.dart';
import '../../../DATA/constants/app_strings.dart';
import '../../themes_configuration/app_colors.dart';
import '../../../DATA/models/app_enums.dart';
import 'dialog_buttons.dart';

/// `AppDialogsStyling` provides the styling and layout structure for custom Android-style dialogs.
/// It includes methods for configuring the dialog's size, content, and buttons.
abstract class AppDialogsStyling {
  /// Creates a custom-styled dialog for Android using Material design principles.
  static Widget customAndroidDialogStyle({
    required BuildContext context,
    required ThemeData theme,
    required Widget contentWidget,
    required EdgeInsets contentPadding,
    required VoidCallback onActionPressed,
    VoidCallback? onCancelPressed,
    required String actionButtonText,
    String? cancelButtonText,
    String? dialogTitle,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dialogSize = _calculateDialogSize(constraints);

        return Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: dialogSize['isPortraitMode']
                      ? constraints.maxHeight * 0.15
                      : 0),
              child: Dialog(
                clipBehavior: Clip.hardEdge,
                shape: AppBordersStyling.appShapeBorder(theme.colorScheme),
                child: ClipRRect(
                  borderRadius: AppConstants.borderRadiusCommon,
                  child: Container(
                    width: dialogSize['width'],
                    height: dialogSize['height'],
                    padding: AppConstants.allPadding0,
                    decoration: AppBoxDecorations.inGlassMorphismStyle(theme),
                    child: Material(
                      child: Stack(
                        children: [
                          // Blurred background effect for the dialog
                          AppBoxDecorations.withBlurEffect(
                            blur: 10,
                            child: Container(
                              decoration:
                                  AppBoxDecorations.inGlassMorphismStyle(theme),
                            ),
                          ),
                          // Main content of the dialog, including title, content, and buttons
                          Container(
                            padding: AppConstants.allPadding0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 26, left: 16, right: 16, bottom: 8),
                                  child: Text(
                                    dialogTitle ?? '',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ),
                                AppMiniWidgets.customDivider(theme),
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
                ),
              ),
            ),
            // Buttons at the bottom of the dialog
            Positioned(
              bottom: dialogSize['isPortraitMode']
                  ? constraints.maxHeight * 0.1
                  : 0,
              left: 0,
              right: 0,
              child: Container(
                color: AppColors.transparent,
                padding: AppConstants.allPadding10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Cancel button
                    AppDialogsButtons.custom(
                      theme,
                      context: context,
                      buttonType: DialogButtonType.cancelButtonInAndroidType,
                      onPressed: onCancelPressed,
                      buttonText: cancelButtonText ?? AppStrings.cancel,
                    ),
                    const SizedBox(width: 10),
                    // Action button
                    ClipRRect(
                      borderRadius: AppConstants.borderRadiusCommon,
                      child: AppDialogsButtons.custom(
                        theme,
                        context: context,
                        buttonType: DialogButtonType.actionButtonInAndroidStyle,
                        onPressed: onActionPressed,
                        buttonText: actionButtonText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// A helper method that calculates the dialog's width, height, and orientation (portrait/landscape).
  static Map<String, dynamic> _calculateDialogSize(BoxConstraints constraints) {
    final isPortraitMode = constraints.maxWidth < 600;
    final widthFraction = isPortraitMode ? 0.85 : 0.85;
    final heightFraction = isPortraitMode ? 0.55 : 0.75;

    return {
      'width': constraints.maxWidth * widthFraction,
      'height': constraints.maxHeight * heightFraction,
      'isPortraitMode': isPortraitMode,
    };
  }
}
