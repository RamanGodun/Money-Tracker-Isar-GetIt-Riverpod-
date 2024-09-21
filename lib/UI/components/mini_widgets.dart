import 'dart:ui';
import 'package:flutter/material.dart';
import '../../data/constants/app_styling_constants.dart';
import '../../data/helpers/helpers.dart';

class AppMiniWidgets {
/* Custom Dividers
 */

  static Widget divider(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final isDarkMode = Helpers.isDarkTheme(theme);
    return Divider(
      thickness: 0.5,
      color: colorScheme.inverseSurface.withOpacity(isDarkMode ? 1 : 0.5),
    );
  }

/*
DIVIDER for CUSTOM DIALOG 
 */

  static Widget dividerBetweenDialogButtons(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    return Container(
      width: 0.5,
      color: colorScheme.inverseSurface.withOpacity(0.5),
    );
  }

  static Widget getDividerBetweenDialogButtons(ThemeData theme) =>
      dividerBetweenDialogButtons(theme);
//

/*
OTHERS (borders)
*/
  static Widget backDropFilter({required Widget child}) {
    return ClipRRect(
      borderRadius: AppStylingConstants.radius12,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: child,
      ),
    );
  }
//
}
