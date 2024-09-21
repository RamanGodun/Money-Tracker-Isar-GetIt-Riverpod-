import 'package:flutter/material.dart';

abstract class AppTextStyling {
  /* General text styles */

  // Загальний стиль тексту для кнопок
  static TextStyle forButtons(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 17,
      letterSpacing: 1.04,
      wordSpacing: 1.96,
      color: colorScheme.onPrimary,
    );
  }

  // Стиль тексту для заголовка в тілі
  static TextStyle bodyMedium(ThemeData theme) {
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return textTheme.bodyMedium!.copyWith(
      color: colorScheme.onSurface,
      fontSize: 16.0,
    );
  }

  // Стиль тексту для текстових полів
  static TextStyle forTextField(ThemeData theme) {
    TextStyle textStyle = theme.textTheme.displayMedium!.copyWith(
      fontSize: 17.5,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300,
    );
    return textStyle;
  }

  // Стиль тексту для дій
  static TextStyle forActionText(ThemeData theme) {
    final TextStyle forActionText =
        theme.textTheme.labelLarge!.copyWith(color: theme.colorScheme.primary);
    return forActionText;
  }

  // Стиль тексту для великого тіла
  static TextStyle bodyLarge(ThemeData theme) {
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return textTheme.bodyLarge!.copyWith(
      color: colorScheme.onSurface,
    );
  }

  // Стиль тексту для label
  static TextStyle label(ThemeData theme) {
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return textTheme.labelSmall!.copyWith(
      color: colorScheme.onSurface,
      height: 0.9,
    );
  }

  // Стиль тексту для помилок
  static TextStyle errorText(ThemeData theme) {
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return textTheme.labelMedium!.copyWith(
      color: colorScheme.error,
    );
  }

  // Стиль тексту для текстових полів форми
  static TextStyle forTextFormField(ThemeData theme, double? textSize) {
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final textStyle = textTheme.bodyMedium!.copyWith(
      color: colorScheme.onSurface,
      fontSize: textSize ?? 17,
      fontWeight: FontWeight.w500,
    );
    return textStyle;
  }

  /* Common Material Button Style */

  // Стиль тексту для кнопок Material
  static TextStyle materialButtonStyle(BuildContext context,
      {required Color color, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      fontSize: 17,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
