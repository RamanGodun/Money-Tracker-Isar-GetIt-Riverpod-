import 'package:flutter/material.dart';

/// A class to manage text styles used throughout the app.
/// Centralized text styles make it easy to update and maintain consistency in the UI.
class TextStyling {
  /// Style for medium-sized titles
  static TextStyle titleMedium(ThemeData theme) {
    return theme.textTheme.titleSmall!.copyWith(
      color: theme.colorScheme.onSurface.withOpacity(0.7),
    );
  }

  /// Style for small-sized titles
  static TextStyle titleSmall(ThemeData theme, {Color? color}) {
    return theme.textTheme.titleSmall!.copyWith(
      color: color ?? theme.colorScheme.onSurface.withOpacity(0.7),
    );
  }

  /// Style for large body text
  static TextStyle bodyLarge(ThemeData theme, {Color? color}) {
    return theme.textTheme.bodyLarge!.copyWith(
      color: color ?? theme.colorScheme.onSurface,
    );
  }

  /// Style for medium body text
  static TextStyle bodyMedium(ThemeData theme, {Color? color}) {
    return theme.textTheme.bodyMedium!.copyWith(
      color: color ?? theme.colorScheme.onSurface.withOpacity(0.7),
    );
  }

  /// Style for small body text
  static TextStyle bodySmall(ThemeData theme, {Color? color}) {
    return theme.textTheme.bodySmall!.copyWith(
      color: color ?? theme.colorScheme.onSurface.withOpacity(0.7),
    );
  }

  /// Style for buttons
  /// [isActionButton] determines if it's a primary (action) button
  static TextStyle forButtons(ThemeData theme, bool isActionButton) {
    return theme.textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 17,
      letterSpacing: 1.04,
      wordSpacing: 1.96,
      color: isActionButton
          ? theme.colorScheme.onPrimary
          : theme.colorScheme.error,
    );
  }

  /// Style for error text
  static TextStyle errorText(ThemeData theme) {
    return theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.error,
    );
  }

  /// Style for text fields
  static TextStyle forTextField(ThemeData theme) {
    return theme.textTheme.displayMedium!.copyWith(
      fontSize: 17.5,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300,
    );
  }

  /// Style for interactive text (e.g., links)
  static TextStyle forActionText(ThemeData theme) {
    return theme.textTheme.labelLarge!.copyWith(
      color: theme.colorScheme.primary,
    );
  }

  /// Style for form fields
  static TextStyle forTextFormField(ThemeData theme, double? textSize) {
    return theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onSurface,
      fontSize: textSize ?? 17,
      fontWeight: FontWeight.w500,
    );
  }

  /// Style for field labels, taking into account error states
  static TextStyle labelForTextField(ThemeData theme, String? errorText) {
    return TextStyle(
        color: errorText != null
            ? theme.colorScheme.error
            : theme.colorScheme.onSurface);
  }
}
