import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../DATA/constants/app_text_styling.dart';
import '../../DATA/constants/app_strings.dart';
import '../../DATA/models/expenses_input_state.dart';

/// A utility class `StyledText` that provides various pre-styled `Text` widgets
/// for consistent typography across the app. Each method returns a `Text` widget
/// with predefined styles based on the `ThemeData` passed to it.
abstract class StyledText {
  /// Returns a `Text` widget with a medium title style.
  static Widget titleMedium(ThemeData theme, String text) {
    return Text(
      text,
      style:
          TextStyling.titleMedium(theme), //  predefined style from TextStyling
    );
  }

  /// Returns a `Text` widget with a small title style.
  static Widget titleSmall(ThemeData theme, String text,
      {Color? color, TextAlign? align}) {
    return Text(
      text,
      textAlign: align ?? TextAlign.start,
      style: TextStyling.titleSmall(theme, color: color),
    );
  }

  /// Returns a `Text` widget with a large body style.
  static Widget bodyLarge(ThemeData theme, String text,
      {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: TextStyling.bodyLarge(theme, color: color),
    );
  }

  /// Returns a `Text` widget with a medium body style.
  static Widget bodyMedium(ThemeData theme, String text,
      {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: TextStyling.bodyMedium(theme, color: color),
    );
  }

  /// Returns a `Text` widget with a small body style.
  static Widget bodySmall(ThemeData theme, String text,
      {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: TextStyling.bodySmall(theme, color: color),
    );
  }

  /// Returns a `Text` widget for button labels.
  static Widget forButtons(ThemeData theme, String text, bool isActionButton,
      {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: TextStyling.forButtons(theme, isActionButton),
    );
  }

  /// Returns a `Text` widget for displaying error messages.
  static Widget errorText(ThemeData theme, String text,
      {Color? color, TextAlign? align}) {
    return Text(
      text,
      textAlign: align ?? TextAlign.start,
      style: TextStyling.errorText(theme),
    );
  }

  /// Returns a `Text` widget for date picker with dynamic text based on whether a date is selected.
  /// If no date is selected, it shows a default message from [AppStrings.noDateSelected] and applies an error style.
  static Widget datePickerText(ThemeData theme, NewExpenseState expenseState) {
    return Text(
        expenseState.date == null
            ? AppStrings.noDateSelected
            : DateFormat('dd.MM.yyyy').format(expenseState.date!),
        style: TextStyle(
          color: expenseState.date == null
              ? theme.colorScheme.error // If no date, apply error color
              : theme.colorScheme.secondary, // Otherwise, apply secondary color
        ));
  }
}
