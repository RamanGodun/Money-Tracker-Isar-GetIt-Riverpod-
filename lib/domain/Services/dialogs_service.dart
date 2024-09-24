import 'package:flutter/material.dart';
import 'package:money_tracker/DATA/constants/app_borders.dart';
import 'package:money_tracker/DATA/constants/strings_4_app.dart';
import '../../DATA/helpers/helpers.dart';
import '../../UI/components/dialog_and_buttons/_buttons_styling.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingsDialogService {
  void showCustomDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    bool isDarkTheme = false,
  }) {
    final theme = Helpers.themeGet(context);

    // Використовуємо Hook для анімації
    showDialog(
      context: context,
      barrierColor:
          theme.colorScheme.shadow.withOpacity(isDarkTheme ? 0.65 : 0.64),
      builder: (context) {
        return _AnimatedSettingsDialog(
          title: title,
          content: content,
          theme: theme,
        );
      },
    );
  }
}

class _AnimatedSettingsDialog extends HookWidget {
  final String title;
  final Widget content;
  final ThemeData theme;

  const _AnimatedSettingsDialog({
    required this.title,
    required this.content,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    // Створюємо контролер для анімації з допомогою хуків
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    )..forward();

    return ScaleTransition(
      scale: animationController,
      child: Dialog(
        backgroundColor: theme.colorScheme.surface.withOpacity(0.95),
        shape: AppBordersStyling.rectangleBorder(theme),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.displaySmall,
              ),
              content,
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: AppButtonsStyling.forElevatedButton(
                  context,
                  buttonText: AppStrings.close,
                  onPressed: () {
                    animationController.reverse().then((_) {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
