import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../domain/helpers/helpers.dart';
import '../../Theme_configuration/app_colors/app_colors.dart';

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

  // Стиль тексту для заголовка AppBar
  static TextStyle appBarTitle(BuildContext context, ThemeData theme) {
    final CupertinoThemeData cupertinoTheme =
        Helpers.cupertinoThemeGet(context);
    final colorScheme = theme.colorScheme;
    return cupertinoTheme.textTheme.navTitleTextStyle
        .copyWith(color: colorScheme.onSurface);
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

  // Стиль тексту для підказки
  static TextStyle hintText(ThemeData theme) {
    final hintText =
        theme.textTheme.bodyMedium!.copyWith(color: AppColors.inactiveGray);
    return hintText;
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

  /* Common Cupertino Button Style */

  // Стиль тексту для кнопок Cupertino
  static TextStyle cupertinoButtonStyle(
    BuildContext context, {
    required Color color,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    final textTheme = Helpers.cupertinoThemeGet(context).textTheme;
    return textTheme.actionTextStyle.copyWith(
      fontSize: 17,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: 1.15,
    );
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

  /* Text styles for FI APP */

  // Стиль тексту для питань
  static TextStyle questionTextStyle(ThemeData theme) {
    final textTheme = theme.textTheme;
    return textTheme.labelSmall!.copyWith(height: 1.15);
  }

  // Стиль тексту для мітки відповіді
  static TextStyle answerLabelStyle(ThemeData theme) {
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return textTheme.bodySmall!.copyWith(
      color: colorScheme.onSurface,
      height: 0.9,
      fontStyle: FontStyle.italic,
    );
  }

  // Стиль тексту для відповіді
  static TextStyle answerTextStyle(ThemeData theme, bool isCorrectAnswer) {
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return textTheme.bodyMedium!.copyWith(
      color: isCorrectAnswer ? colorScheme.primary : colorScheme.error,
      height: 1.05,
    );
  }

  // Стиль тексту для вибору складності
  static TextStyle? forComplexityPicker(ThemeData theme, int selectedSegment) {
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return textTheme.displayMedium?.copyWith(
      color:
          selectedSegment == 0 ? colorScheme.onPrimary : colorScheme.onSurface,
    );
  }

  // Стиль тексту для вибору функціональних інтерв'ю
  static TextStyle forFIPicker(ThemeData theme, ColorScheme colorScheme) {
    return theme.textTheme.displayLarge!
        .copyWith(color: colorScheme.onTertiary.withOpacity(0.67));
  }
}
