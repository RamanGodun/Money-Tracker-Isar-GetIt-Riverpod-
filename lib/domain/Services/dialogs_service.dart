import 'package:flutter/material.dart';
import 'package:money_tracker/DATA/constants/app_borders.dart';
import 'package:money_tracker/DATA/constants/strings_4_app.dart';
import 'package:money_tracker/UI/components/text_widgets.dart';
import '../../DATA/helpers/helpers.dart';
import '../../UI/components/dialog_and_buttons/_buttons_styling.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingsDialogService {
  // Змінюємо метод для відображення діалогу з новою темою
  void showCustomDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    bool isDarkTheme = false,
  }) {
    final theme = Helpers.themeGet(context);

    showDialog(
      context: context,
      barrierColor:
          theme.colorScheme.shadow.withOpacity(isDarkTheme ? 0.65 : 0.64),
      builder: (context) {
        return _AnimatedSettingsDialog(
          title: title,
          content: content,
        );
      },
    );
  }
}

class _AnimatedSettingsDialog extends HookWidget {
  final String title;
  final Widget content;

  const _AnimatedSettingsDialog({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    )..forward();

    final theme = Helpers.themeGet(context);
    final isDarkMode = Helpers.isDarkTheme(theme);

    return ScaleTransition(
      scale: animationController,
      child: Dialog(
        backgroundColor:
            theme.colorScheme.surface.withOpacity(isDarkMode ? 1 : 0.6),
        shape: AppBordersStyling.rectangleBorder(theme),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StyledText.titleMedium(theme, title),
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
