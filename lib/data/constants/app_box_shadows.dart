import 'package:flutter/material.dart';
import '../helpers/helpers.dart';
import '../Theme_configuration/app_colors/app_colors.dart';

abstract class AppBoxShadows {
  /* Головні тіні для діалогів у стилі гласморфізму */
  static BoxShadow forDialog1(ThemeData theme, bool isIOS) {
    final colorScheme = theme.colorScheme;
    final isDarkMode = Helpers.isDarkTheme(theme);
    return BoxShadow(
      color: isDarkMode
          ? Colors.black.withOpacity(0.5)
          : colorScheme.inverseSurface.withOpacity(0.2),
      spreadRadius: 2,
      blurRadius: 12,
      offset: const Offset(2, 6),
    );
  }

  static BoxShadow forDialog2(ThemeData theme, bool isIOS) {
    final colorScheme = theme.colorScheme;
    final isDarkMode = Helpers.isDarkTheme(theme);
    return BoxShadow(
      color: isDarkMode
          ? AppColors.cupertinoBlackColor.withOpacity(0.25)
          : colorScheme.inverseSurface.withOpacity(0.1),
      spreadRadius: 1,
      blurRadius: 6,
      offset: isIOS ? const Offset(0, 2) : Offset.zero,
    );
  }

  /* Тіні для стилю гласморфізму */
  static BoxShadow forGlassMorphism1(ThemeData theme, bool isDarkMode) {
    return BoxShadow(
      color: AppColors.cupertinoBlackColor.withOpacity(isDarkMode ? 0.5 : 0.7),
      spreadRadius: 2,
      blurRadius: 8,
      offset: const Offset(2, 4),
    );
  }

  static BoxShadow forGlassMorphism2(ThemeData theme, bool isDarkMode) {
    return BoxShadow(
      color: AppColors.cupertinoBlackColor.withOpacity(isDarkMode ? 0.3 : 0.4),
      spreadRadius: 1,
      blurRadius: 4,
      offset: const Offset(0, 2),
    );
  }
}
