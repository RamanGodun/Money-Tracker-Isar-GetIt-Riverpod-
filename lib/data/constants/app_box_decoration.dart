import 'package:flutter/material.dart';
import '../helpers/helpers.dart';
import 'app_box_shadows.dart';
import 'app_constants.dart';
import 'dart:ui';

abstract class AppBoxDecorations {
  // Стилізація для гласморфізму
  static BoxDecoration inGlassMorphismStyle(ThemeData theme) {
    final isDark = Helpers.isDarkTheme(theme);
    final colorScheme = theme.colorScheme;

    return BoxDecoration(
      color: isDark
          ? colorScheme.onSurface.withOpacity(0.2)
          : colorScheme.surfaceContainer.withOpacity(0.3),
      borderRadius: AppConstants.commonBorderRadius,
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

  // Ефект розмиття з врахуванням форми
  static Widget withBlurEffect({required Widget child, required double blur}) {
    return ClipRRect(
      borderRadius: AppConstants.commonBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: child,
      ),
    );
  }

  // Стилізація для графіків
  static BoxDecoration forGraphics(ThemeData theme, bool isMainChart) {
    final isDarkMode = theme.brightness == Brightness.dark;
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      color: isMainChart
          ? theme.colorScheme.secondary.withOpacity(isDarkMode ? 0.8 : 0.6)
          : theme.canvasColor.withOpacity(isDarkMode ? 0.5 : 0.4),
    );
  }
}
