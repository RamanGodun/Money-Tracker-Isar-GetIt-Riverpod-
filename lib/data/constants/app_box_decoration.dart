import 'package:flutter/material.dart';
import 'app_styling_constants.dart';
import '../helpers/helpers.dart';
import 'app_borders.dart';
import 'app_box_shadows.dart';

abstract class AppBoxDecorations {
  /* BoxDecoration для кнопок у стилі "GLASS MORPHISM" */
  static BoxDecoration forButtonsInGlassMorphismStyle(ThemeData theme) {
    final isDark = Helpers.isDarkTheme(theme);
    final colorScheme = theme.colorScheme;
    return BoxDecoration(
      color: colorScheme.primary.withOpacity(isDark ? 0.35 : 0.6),
      borderRadius: AppStylingConstants.commonBorderRadius,
      boxShadow: [
        AppBoxShadows.glassMorphismShadow1(theme, isDark),
        AppBoxShadows.glassMorphismShadow2(theme, isDark),
      ],
      border: Border.all(
        color: colorScheme.onSurface.withOpacity(0.1),
      ),
    );
  }

  /* BoxDecoration для Android Dialog */
  static BoxDecoration forAndroidDialog(ThemeData theme) {
    return BoxDecoration(
      border: AppBordersStyling.forAndroidBoxDecoration(theme),
      borderRadius: AppStylingConstants.radius12,
      color: theme.colorScheme.surface.withOpacity(0.4),
      boxShadow: [
        AppBoxShadows.customDialogShadow1(theme, false),
        AppBoxShadows.customDialogShadow2(theme, false),
      ],
    );
  }

  /* BoxDecoration для низьких контейнерів */
  static BoxDecoration forAndroidDialog1(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    return BoxDecoration(
      color: colorScheme.surface.withOpacity(0.6),
      borderRadius: AppStylingConstants.radius12,
      border: Border.all(
        color: colorScheme.inverseSurface.withOpacity(0.1),
      ),
    );
  }
}
