import 'package:flutter/material.dart';

import '../../UI/components/buttons/_buttons_styling.dart';

class CustomDialogService {
  void showCustomDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    required ThemeData theme,
    bool isDarkTheme = false,
  }) {
    showDialog(
      context: context,
      barrierColor:
          theme.colorScheme.shadow.withOpacity(isDarkTheme ? 0.65 : 0.64),
      builder: (context) {
        return Dialog(
          backgroundColor: theme.colorScheme.surface.withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displaySmall),
                content,
                const SizedBox(height: 20),
                SizedBox(
                    width: 200,
                    child: AppButtonsStyling.forElevatedButton(context,
                        buttonText: 'Закрити', onPressed: () {
                      Navigator.of(context).pop();
                    })),
              ],
            ),
          ),
        );
      },
    );
  }
}
