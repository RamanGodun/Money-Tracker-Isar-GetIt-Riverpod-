import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class Helpers {
  /*
  Here some useful methods, used across all app
  */
  /// Get the current theme data.
  static ThemeData themeGet(BuildContext context) {
    return Theme.of(context);
  }

  /// Get the color scheme from the current theme.
  static ColorScheme colorSchemeGet(BuildContext context) {
    return themeGet(context).colorScheme;
  }

  /// Get the text theme from the current theme.
  static TextTheme textThemeGet(BuildContext context) {
    return themeGet(context).textTheme;
  }

  /// Determine if the current theme is dark mode.
  static bool isDarkMode(BuildContext context) {
    return themeGet(context).brightness == Brightness.dark;
  }

  /// Determine if the given theme data is in dark mode.
  static bool isDarkTheme(ThemeData theme) {
    return theme.brightness == Brightness.dark;
  }

  /// Get the device size.
  static Size deviceSizeGet(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Get the device height.
  static double deviceHeightGet(BuildContext context) {
    return deviceSizeGet(context).height;
  }

  /// Get the device width.
  static double deviceWidthGet(BuildContext context) {
    return deviceSizeGet(context).width;
  }

/* Converting & formatting of data
*/
  double convertStringToDouble(String inputString) {
    double? amount = double.tryParse(inputString);
    return amount ?? 0;
  }

  String formattedTime(DateTime dateTime) {
    return DateFormat.yMMMMd().format(dateTime);
  }

  String formatAmount(double inputAmount) {
    String formattedAmount;
    if (inputAmount >= 1000) {
      formattedAmount = NumberFormat.compact().format(inputAmount.round());
    } else {
      formattedAmount = NumberFormat.currency(
        locale: 'uk_UA',
        symbol: '₴',
        decimalDigits: 1,
      ).format(inputAmount);
    }
    if (inputAmount >= 1000) {
      formattedAmount += '₴';
    }
    return formattedAmount;
  }

/* Navigation methods
*/
  static void push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  void callSnackBar(
      BuildContext context, String content, Color backgroundColor) {
    return SchedulerBinding.instance.addPostFrameCallback((_) {
      Helpers.showSnackBar(context, content, backgroundColor);
    });
  }

/* Snackbars
*/
  static void clearSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static void showSnackBar(
      BuildContext ctx, String content, Color? backgroundColor) {
    bool isDarkTheme = Helpers.isDarkMode(ctx);
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2350),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: Helpers.deviceHeightGet(ctx) * 0.85),
        backgroundColor: (backgroundColor != null)
            ? backgroundColor
            : isDarkTheme
                ? colorSchemeGet(ctx).surface.withOpacity(0.75)
                : colorSchemeGet(ctx).surface.withOpacity(0.9),
        content: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            content,
            style: Helpers.textThemeGet(ctx)
                .titleSmall!
                .copyWith(color: Helpers.colorSchemeGet(ctx).secondary),
          ),
        ),
      ),
    );
  }

/*
 */
}
