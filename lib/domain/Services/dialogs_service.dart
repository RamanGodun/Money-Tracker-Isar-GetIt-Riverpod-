import 'package:flutter/material.dart';
import 'package:money_tracker/DATA/constants/app_borders.dart';
import 'package:money_tracker/DATA/constants/app_strings.dart';
import 'package:money_tracker/UI/components/text_widgets.dart';
import '../../DATA/helpers/helpers.dart';
import '../../UI/components/dialog_and_buttons/buttons_styling.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Service class responsible for displaying custom dialogs in the app.
/// This class provides methods to show dialogs with custom content and
/// customizable theming options.
class SettingsDialogService {
  /// Displays a custom dialog with the given [title] and [content].
  /// The dialog supports light and dark themes based on the [isDarkTheme] flag.
  void showCustomDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    bool isDarkTheme = false,
  }) {
    // Get the current theme from the provided context
    final theme = Helpers.getTheme(context);

    // Show the dialog with a customizable barrier color and content
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

/// Private widget class that provides an animated dialog for displaying
/// settings-related content. The dialog includes an animated scale transition
/// when it appears and disappears.
class _AnimatedSettingsDialog extends HookWidget {
  final String title;
  final Widget content;

  /// Constructor for initializing the dialog with a [title] and [content].
  const _AnimatedSettingsDialog({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    // Create an animation controller for handling dialog animations
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    )..forward(); // Start the animation when the widget is built

    // Get the current theme and device size from the provided context
    final theme = Helpers.getTheme(context);
    final isDarkMode = Helpers.isDarkTheme(theme);
    final deviceSize = Helpers.getDeviceSize(context);

    // Build a scale transition dialog with custom styling and animation
    return ScaleTransition(
      scale: animationController,
      child: Dialog(
        backgroundColor: isDarkMode
            ? theme.colorScheme.surfaceBright.withOpacity(0.9)
            : theme.colorScheme.surface.withOpacity(0.75),
        shape: AppBordersStyling.appShapeBorder(theme.colorScheme),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display the title of the dialog
              StyledText.titleMedium(theme, title),
              // Display the custom content passed to the dialog
              content,
              const SizedBox(height: 20),
              // Display the close button at the bottom of the dialog
              SizedBox(
                width: deviceSize.width * 0.6,
                child: AppButtonsStyling.forElevatedButton(
                  context,
                  buttonText: AppStrings.close,
                  onPressed: () {
                    // Reverse the animation and close the dialog
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
