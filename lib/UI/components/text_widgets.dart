import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../DATA/constants/app_text_styling.dart';
import '../../DATA/constants/strings_4_app.dart';
import '../../DOMAIN/models/expenses_input_state.dart';

abstract class StyledText {
  static Widget titleMedium(ThemeData theme, String text) {
    return Text(
      text,
      style: TextStyling.titleMedium(theme),
    );
  }

  static Widget titleSmall(ThemeData theme, String text,
      {Color? color, TextAlign? align}) {
    return Text(
      text,
      textAlign: align ?? TextAlign.start,
      style: TextStyling.titleSmall(theme, color: color),
    );
  }

  static Widget bodyLarge(ThemeData theme, String text,
      {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: TextStyling.bodyLarge(theme, color: color),
    );
  }

  static Widget bodyMedium(ThemeData theme, String text,
      {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: TextStyling.bodyMedium(theme, color: color),
    );
  }

  static Widget bodySmall(ThemeData theme, String text,
      {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: TextStyling.bodySmall(theme, color: color),
    );
  }

  static Widget forButtons(ThemeData theme, String text, bool isActionButton,
      {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: TextStyling.forButtons(theme, isActionButton),
    );
  }

  static Widget errorText(ThemeData theme, String text,
      {Color? color, TextAlign? align}) {
    return Text(
      text,
      textAlign: align ?? TextAlign.start,
      style: TextStyling.errorText(theme),
    );
  }

  static Widget datePickerText(ThemeData theme, NewExpenseState expenseState) {
    return Text(
        expenseState.date == null
            ? AppStrings.noDateSelected
            : DateFormat('dd.MM.yyyy').format(expenseState.date!),
        style: TextStyle(
          color: expenseState.date == null
              ? theme.colorScheme.error
              : theme.colorScheme.secondary,
        ));
  }
}
