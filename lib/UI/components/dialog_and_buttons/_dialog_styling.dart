import 'package:flutter/material.dart';
import 'package:money_tracker/UI/components/other_widgets.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/constants/app_borders.dart';
import '../../../DATA/constants/app_box_decoration.dart';
import '../../themes_configuration/app_colors.dart';
import '../../../DATA/models/app_enums.dart';
import 'dialog_buttons.dart';

abstract class AppDialogsStyling {
  static Widget customAndroidDialogStyle({
    required BuildContext context,
    required ThemeData theme,
    required Widget contentWidget,
    required EdgeInsets contentPadding,
    required VoidCallback onActionPressed,
    onCancelPressed,
    required String actionButtonText,
    cancelButtonText,
    dialogTitle,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isPortraitMode = constraints.maxWidth < 600;
        final widthFraction = isPortraitMode ? 0.77 : 0.85;
        final heightFraction = isPortraitMode ? 0.6 : 0.75;

        return Stack(
          children: [
            Dialog(
              clipBehavior: Clip.hardEdge,
              shape: AppBordersStyling.appShapeBorder(theme.colorScheme),
              child: ClipRRect(
                borderRadius: AppConstants.borderRadiusCommon,
                child: Container(
                  width: constraints.maxWidth * widthFraction,
                  height: constraints.maxHeight * heightFraction,
                  padding: AppConstants.allPadding0,
                  decoration: AppBoxDecorations.inGlassMorphismStyle(theme),
                  child: Material(
                    child: Stack(
                      children: [
                        AppBoxDecorations.withBlurEffect(
                          blur: 10,
                          child: Container(
                              decoration:
                                  AppBoxDecorations.inGlassMorphismStyle(
                                      theme)),
                        ),
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
                                  dialogTitle,
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
            Positioned(
              bottom: isPortraitMode ? 30 : 0,
              left: 0,
              right: 0,
              child: Container(
                color: AppColors.transparent,
                padding: AppConstants.allPadding10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppDialogsButtons.custom(
                      theme,
                      context: context,
                      buttonType: DialogButtonType.cancelButtonInAndroidType,
                      onPressed: onCancelPressed,
                      buttonText: cancelButtonText,
                    ),
                    const SizedBox(width: 10),
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
}
