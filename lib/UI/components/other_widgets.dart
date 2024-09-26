import 'package:flutter/material.dart';
import '../../DATA/helpers/helpers.dart';
import '../../DATA/models/app_enums.dart';

/// A utility class `AppMiniWidgets` that provides small reusable widgets such as dividers and padding wrappers.
/// These widgets help maintain consistent styling throughout the app.
class AppMiniWidgets {
/* 
  Builds a customizable divider widget with adjustable thickness and color.
 */
  static Widget customDivider(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final isDarkMode = Helpers.isDarkTheme(theme);
    return Divider(
      thickness: 0.5,
      color: colorScheme.inverseSurface.withOpacity(isDarkMode ? 1 : 0.5),
    );
  }

/*
  A customized divider for use in dialogs, typically placed between dialog buttons.
 */
  static Widget dialogDivider(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    return Container(
      width: 0.5,
      color: colorScheme.inverseSurface.withOpacity(0.5),
    );
  }

  /*
    Returns a divider for use between dialog buttons. This method provides a shorthand for creating
    a divider without directly calling `dialogDivider`.
    */
  static Widget getDialogDivider(ThemeData theme) => dialogDivider(theme);

  /// Applies padding to a specific side of a widget.
  static Widget onlyPadding(Widget child, Side side, double padding) {
    return Padding(
      padding: _getPaddingForSide(side, padding),
      child: child,
    );
  }

  /// Helper method to return the appropriate `EdgeInsets` based on the [side] and [padding] provided.
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
}
