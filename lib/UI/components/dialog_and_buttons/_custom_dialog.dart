import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/constants/app_strings.dart';
import '../../../DOMAIN/Services/animation_controller_service.dart';
import '_dialog_styling.dart';

/// `CustomDialog` is a reusable dialog widget that provides a flexible interface
/// for both Android and iOS-style dialogs. It features animated scaling, a customizable
/// title, action buttons, and content.
class CustomDialog extends HookWidget {
  /// Widget displayed in the dialog's content area.
  final Widget contentWidget;

  /// Padding around the content widget.
  final EdgeInsets contentPadding;

  /// Title displayed at the top of the dialog.
  final String dialogTitle;

  /// Text for the action (confirmation) button.
  final String actionButtonText;

  /// Text for the cancel button.
  final String cancelButtonText;

  /// Determines if the dialog should use iOS styling.
  final bool isIOSStyle;

  /// Callback executed when the action button is pressed.
  final VoidCallback onActionPressed;

  /// Callback executed when the cancel button is pressed.
  final VoidCallback onCancelPressed;

  /// Theme used for dialog styling.
  final ThemeData theme;

  /// Animation service for controlling dialog animations.
  final AnimationService animationService;

  const CustomDialog({
    super.key,
    required this.contentWidget,
    required this.onActionPressed,
    required this.onCancelPressed,
    required this.theme,
    required this.animationService,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.dialogTitle = AppStrings.customDialogTitle,
    this.actionButtonText = AppStrings.ok,
    this.cancelButtonText = AppStrings.cancel,
    this.isIOSStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder rebuilds the dialog based on the animation controller's value
    return AnimatedBuilder(
      animation: animationService.controller,
      builder: (context, child) {
        return Transform.scale(
          scale: animationService.controller.value,
          child: Center(
            child: ClipRRect(
              borderRadius: AppConstants.borderRadiusCommon,
              child: AppDialogsStyling.customAndroidDialogStyle(
                context: context,
                theme: theme,
                dialogTitle: dialogTitle,
                contentWidget: contentWidget,
                contentPadding: contentPadding,
                onActionPressed: onActionPressed,
                onCancelPressed: onCancelPressed,
                actionButtonText: actionButtonText,
                cancelButtonText: cancelButtonText,
              ),
            ),
          ),
        );
      },
    );
  }
}
