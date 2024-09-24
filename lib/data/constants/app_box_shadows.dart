import 'package:flutter/material.dart';
import '../themes_set/app_themes/app_colors.dart';

abstract class AppBoxShadows {
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
