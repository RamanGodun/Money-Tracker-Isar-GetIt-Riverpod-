import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '_dialogs_styling.dart';

class CustomDialog extends HookWidget {
  final Widget contentWidget;
  final EdgeInsets contentPadding;
  final double widthFraction;
  final double heightFraction;
  final String dialogTitle;
  final bool isIOSStyle;
  final VoidCallback onActionPressed;
  final VoidCallback onCancelPressed;
  final String actionButtonText;
  final String cancelButtonText;

  const CustomDialog({
    super.key,
    required this.contentWidget,
    required this.onActionPressed, // Дія для кнопки "ОК"
    required this.onCancelPressed, // Дія для кнопки "Відміна"
    this.widthFraction = 0.8,
    this.heightFraction = 0.7,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.dialogTitle = 'Custom Dialog title',
    this.actionButtonText = 'ОК', // Текст для кнопки "ОК"
    this.cancelButtonText = 'Відміна', // Текст для кнопки "Відміна"
    this.isIOSStyle = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Material(
          child: AppDialogsStyling.customAndroidDialogStyle(
            context: context,
            widthFraction: widthFraction,
            heightFraction: heightFraction,
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
  }
}
