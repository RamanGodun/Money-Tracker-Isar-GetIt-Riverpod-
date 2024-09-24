import 'package:flutter/material.dart';
import 'app_constants.dart';
import '../helpers/helpers.dart';
import 'app_borders.dart';
import 'app_box_shadows.dart';

abstract class AppBoxDecorations {
  /* BoxDecoration для кнопок у стилі "GLASS MORPHISM" */
  static BoxDecoration inGlassMorphismStyle(ThemeData theme) {
    final isDark = Helpers.isDarkTheme(theme);
    final colorScheme = theme.colorScheme;
    return BoxDecoration(
      color: colorScheme.primary.withOpacity(isDark ? 0.35 : 0.6),
      borderRadius: AppConstants.commonBorderRadius,
      border: Border.all(
        color: colorScheme.onSurface.withOpacity(0.1),
      ),
      boxShadow: [
        AppBoxShadows.forGlassMorphism1(theme, isDark),
        AppBoxShadows.forGlassMorphism2(theme, isDark),
      ],
    );
  }

  /* BoxDecoration для Android Dialog */
  static BoxDecoration withShadows(ThemeData theme) {
    return BoxDecoration(
      color: theme.colorScheme.surface.withOpacity(0.4),
      borderRadius: AppConstants.radius12,
      border: AppBordersStyling.forAndroidBoxDecoration(theme),
      boxShadow: [
        AppBoxShadows.forDialog1(theme, false),
        AppBoxShadows.forDialog2(theme, false),
      ],
    );
  }

  /* BoxDecoration для низьких контейнерів */
  static BoxDecoration withoutShadows(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    return BoxDecoration(
      color: colorScheme.surface.withOpacity(0.6),
      borderRadius: AppConstants.radius12,
      border: Border.all(
        color: colorScheme.inverseSurface.withOpacity(0.1),
      ),
    );
  }
}
