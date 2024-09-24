import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '_dialog_styling.dart';

class CustomDialog extends HookWidget {
  final Widget contentWidget;
  final EdgeInsets contentPadding;
  final String dialogTitle, actionButtonText, cancelButtonText;
  final bool isIOSStyle;
  final VoidCallback onActionPressed, onCancelPressed;

  const CustomDialog({
    super.key,
    required this.contentWidget,
    required this.onActionPressed,
    required this.onCancelPressed,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.dialogTitle = 'Custom Dialog title',
    this.actionButtonText = 'ОК',
    this.cancelButtonText = 'Відміна',
    this.isIOSStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: AppDialogsStyling.customAndroidDialogStyle(
          context: context,
          dialogTitle: dialogTitle,
          contentWidget: contentWidget,
          contentPadding: contentPadding,
          onActionPressed: onActionPressed,
          onCancelPressed: onCancelPressed,
          actionButtonText: actionButtonText,
          cancelButtonText: cancelButtonText,
        ),
      ),
    );
  }
}
