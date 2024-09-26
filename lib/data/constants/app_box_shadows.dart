import 'package:flutter/material.dart';

/// A class to manage shadow styles in the app.
/// Responsible for defining shadows for various components.

abstract class AppBoxShadows {
  /// First shadow for glassmorphism style
  static BoxShadow forGlassMorphism1(ThemeData theme, bool isDarkMode) {
    return BoxShadow(
      color: theme.colorScheme.shadow.withOpacity(isDarkMode ? 0.01 : 0.2),
      spreadRadius: 2,
      blurRadius: 8,
      offset: const Offset(2, 4),
    );
  }

  /// Second shadow for glassmorphism style
  static BoxShadow forGlassMorphism2(ThemeData theme, bool isDarkMode) {
    return BoxShadow(
      color: theme.colorScheme.shadow.withOpacity(isDarkMode ? 0.01 : 0.1),
      spreadRadius: 1,
      blurRadius: 4,
      offset: const Offset(0, 2),
    );
  }
}
