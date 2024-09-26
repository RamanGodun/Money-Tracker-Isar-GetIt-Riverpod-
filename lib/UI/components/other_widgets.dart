import 'package:flutter/material.dart';
import '../../DATA/helpers/helpers.dart';
import '../../DATA/models/app_enums.dart';

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

  static Widget onlyPadding(Widget child, Side side, double padding) {
    return Padding(
      padding: _getPaddingForSide(side, padding),
      child: child,
    );
  }

  static EdgeInsets _getPaddingForSide(Side side, double padding) {
    switch (side) {
      case Side.top:
        return EdgeInsets.only(top: padding);
      case Side.left:
        return EdgeInsets.only(left: padding);
      case Side.right:
        return EdgeInsets.only(right: padding);
      case Side.bottom:
        return EdgeInsets.only(bottom: padding);
      default:
        return const EdgeInsets.all(0);
    }
  }

//
}
