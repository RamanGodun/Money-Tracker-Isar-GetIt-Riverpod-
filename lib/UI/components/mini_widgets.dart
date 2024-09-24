import 'dart:ui';
import 'package:flutter/material.dart';
import '../../DATA/constants/app_constants.dart';
import '../../DATA/helpers/helpers.dart';

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
backDropFilter
*/
  static Widget backDropFilter({required Widget child}) {
    return ClipRRect(
      borderRadius: AppConstants.radius12,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: child,
      ),
    );
  }
//
//
// TEXTS WIDGETS

  static Widget smallTitle(ThemeData theme, String content) {
    return Text(
      content,
      style: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(0.7),
      ),
    );
  }
}
