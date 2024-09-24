import 'package:flutter/material.dart';

import '../helpers/helpers.dart';
import 'app_box_shadows.dart';
import 'app_constants.dart';

import 'dart:ui';

abstract class AppBoxDecorations {
  /* BoxDecoration для елементів у стилі "GLASS MORPHISM" з ефектом розмиття */
  static BoxDecoration inGlassMorphismStyle(ThemeData theme) {
    final isDark = Helpers.isDarkTheme(theme);
    final colorScheme = theme.colorScheme;
    return BoxDecoration(
      color: colorScheme.primary.withOpacity(isDark ? 0.15 : 0.3),
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

  /* Метод для додавання BackdropFilter */
  static Widget withBlurEffect({required Widget child, required double blur}) {
    return ClipRRect(
      borderRadius: AppConstants.commonBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: child,
      ),
    );
  }
}
