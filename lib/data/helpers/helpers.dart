import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

/// A utility class that contains various helper methods used across the app.
/// Provides easy access to theme-related data, device properties, formatting, and navigation utilities.
class Helpers {
  /*
  Theme-related helpers
  */

  /// Get the current theme data.
  static ThemeData getTheme(BuildContext context) {
    return Theme.of(context);
  }

  /// Get the color scheme from the current theme.
  static ColorScheme getColorScheme(BuildContext context) {
    return getTheme(context).colorScheme;
  }

  /// Get the text theme from the current theme.
  static TextTheme getTextTheme(BuildContext context) {
    return getTheme(context).textTheme;
  }

  /// Determine if the current theme is dark mode.
  static bool isDarkMode(BuildContext context) {
    return getTheme(context).brightness == Brightness.dark;
  }

  /// Determine if the given theme data is in dark mode.
  static bool isDarkTheme(ThemeData theme) {
    return theme.brightness == Brightness.dark;
  }

  /*
  Device-related helpers
  */

  /// Get the size of the device screen.
  static Size getDeviceSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Get the height of the device screen.
  static double getDeviceHeight(BuildContext context) {
    return getDeviceSize(context).height;
  }

  /// Get the width of the device screen.
  static double getDeviceWidth(BuildContext context) {
    return getDeviceSize(context).width;
  }

  /*
  Data conversion & formatting
  */

  /// Converts a string to a double, returns 0 if parsing fails.
  double convertStringToDouble(String inputString) {
    double? amount = double.tryParse(inputString);
    return amount ?? 0;
  }

  /// Formats a DateTime object to a readable string.
  String formattedTime(DateTime dateTime) {
    return DateFormat.yMMMMd().format(dateTime);
  }

  /// Formats a double to a currency string.
  /// If the value is above 1000, it formats it in a compact form with a currency symbol.
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

  /*
  Navigation helpers
  */

  /// Navigates to the given page.
  static void push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  /// Closes the current page.
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  /// Displays a snackbar after a frame has finished rendering.
  void triggerSnackBar(
      BuildContext context, String content, Color backgroundColor) {
    return SchedulerBinding.instance.addPostFrameCallback((_) {
      Helpers.showSnackBar(context, content, backgroundColor);
    });
  }

  /*
  Snackbar helpers
  */

  /// Hides the current snackbar.
  static void clearSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// Displays a custom snackbar.
  /// Allows setting a background color or uses a default color based on the theme.
  static void showSnackBar(
      BuildContext ctx, String content, Color? backgroundColor) {
    bool isDarkTheme = Helpers.isDarkMode(ctx);
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2350),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: Helpers.getDeviceHeight(ctx) * 0.85),
        backgroundColor: (backgroundColor != null)
            ? backgroundColor
            : isDarkTheme
                ? getColorScheme(ctx).surface.withOpacity(0.75)
                : getColorScheme(ctx).surface.withOpacity(0.9),
        content: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            content,
            style: Helpers.getTextTheme(ctx)
                .titleSmall!
                .copyWith(color: Helpers.getColorScheme(ctx).secondary),
          ),
        ),
      ),
    );
  }
}
