import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/constants/strings_4_app.dart';
import '../../../DOMAIN/Services/animation_controller_service.dart';
import '_dialog_styling.dart';

class CustomDialog extends HookWidget {
  final Widget contentWidget;
  final EdgeInsets contentPadding;
  final String dialogTitle, actionButtonText, cancelButtonText;
  final bool isIOSStyle;
  final VoidCallback onActionPressed, onCancelPressed;
  final ThemeData theme;
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
