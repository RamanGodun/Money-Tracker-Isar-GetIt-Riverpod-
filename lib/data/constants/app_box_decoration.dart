import 'package:flutter/material.dart';
import '../helpers/helpers.dart';
import 'app_box_shadows.dart';
import 'app_constants.dart';
import 'dart:ui';

/// A class to manage BoxDecoration styles used throughout the app.
/// This includes glassmorphism, graphics styles, and blur effects.

abstract class AppBoxDecorations {
  /// Glassmorphism style background
  static BoxDecoration inGlassMorphismStyle(ThemeData theme) {
    final isDark = Helpers.isDarkTheme(theme);
    final colorScheme = theme.colorScheme;
    return BoxDecoration(
      color: isDark
          ? colorScheme.onSurface.withOpacity(0.2)
          : colorScheme.surfaceContainer.withOpacity(0.3),
      borderRadius: AppConstants.borderRadiusCommon,
      border: Border.all(
        color: colorScheme.onSurface.withOpacity(0.1),
      ),
      boxShadow: [
        AppBoxShadows.forGlassMorphism1(theme, isDark),
        AppBoxShadows.forGlassMorphism2(theme, isDark),
      ],
      backgroundBlendMode: BlendMode.overlay,
    );
  }

  /// Decoration style for charts and graphics
  static BoxDecoration forGraphics(ThemeData theme, bool isMainChart) {
    final isDarkMode = theme.brightness == Brightness.dark;
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      color: isMainChart
          ? theme.colorScheme.secondary.withOpacity(isDarkMode ? 0.8 : 0.6)
          : theme.canvasColor.withOpacity(isDarkMode ? 0.4 : 0.15),
    );
  }

  /// Blur effect for components
  static Widget withBlurEffect({required Widget child, required double blur}) {
    return ClipRRect(
      borderRadius: AppConstants.borderRadiusCommon,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: child,
      ),
    );
  }
}
