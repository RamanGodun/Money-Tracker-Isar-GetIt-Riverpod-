import 'package:flutter/material.dart';

class TextStyling {
  static TextStyle titleMedium(ThemeData theme) {
    return theme.textTheme.titleSmall!.copyWith(
      color: theme.colorScheme.onSurface.withOpacity(0.7),
    );
  }

  static TextStyle titleSmall(ThemeData theme, {Color? color}) {
    return theme.textTheme.titleSmall!.copyWith(
      color: color ?? theme.colorScheme.onSurface.withOpacity(0.7),
    );
  }

  static TextStyle bodyLarge(ThemeData theme, {Color? color}) {
    return theme.textTheme.bodyLarge!.copyWith(
      color: color ?? theme.colorScheme.onSurface,
    );
  }

  static TextStyle bodyMedium(ThemeData theme, {Color? color}) {
    return theme.textTheme.bodyMedium!.copyWith(
      color: color ?? theme.colorScheme.onSurface.withOpacity(0.7),
    );
  }

  static TextStyle bodySmall(ThemeData theme, {Color? color}) {
    return theme.textTheme.bodySmall!.copyWith(
      color: color ?? theme.colorScheme.onSurface.withOpacity(0.7),
    );
  }

  static TextStyle forButtons(ThemeData theme) {
    return theme.textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 17,
      letterSpacing: 1.04,
      wordSpacing: 1.96,
      color: theme.colorScheme.onPrimary,
    );
  }

  static TextStyle errorText(ThemeData theme) {
    return theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.error,
    );
  }

  static TextStyle forTextField(ThemeData theme) {
    return theme.textTheme.displayMedium!.copyWith(
      fontSize: 17.5,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle forActionText(ThemeData theme) {
    return theme.textTheme.labelLarge!.copyWith(
      color: theme.colorScheme.primary,
    );
  }

  static TextStyle forTextFormField(ThemeData theme, double? textSize) {
    return theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onSurface,
      fontSize: textSize ?? 17,
      fontWeight: FontWeight.w500,
    );
  }
}
