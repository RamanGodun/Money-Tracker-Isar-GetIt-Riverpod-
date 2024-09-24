import 'package:flutter/material.dart';
import '../../DATA/constants/app_text_styling.dart';

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
}
