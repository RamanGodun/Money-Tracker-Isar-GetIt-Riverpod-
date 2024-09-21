import 'package:flutter/material.dart';

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
      barrierColor: theme.colorScheme.onTertiaryContainer
          .withOpacity(isDarkTheme ? 0.85 : 0.44),
      builder: (context) {
        return Dialog(
          backgroundColor: theme.colorScheme.surface.withOpacity(0.75),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 20),
                content,
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              theme.colorScheme.secondary.withOpacity(0.95),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Закрити',
                          style: theme.textTheme.displaySmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
