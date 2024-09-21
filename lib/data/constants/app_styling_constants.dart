import 'package:flutter/material.dart';

abstract class AppStylingConstants {
  // Елевація
  static const double elevation = 0;

  // Загальний радіус для обводки
  static const double generalBorderRadius = 12.0;

  // Висота кнопок
  static const double buttonsHeight = 50;

  // Розмір іконок
  static const double iconSize = 28;

  // Загальний радіус для обводки, що використовується часто
  static final BorderRadius commonBorderRadius =
      BorderRadius.circular(generalBorderRadius);

  // Радіус 12, часто використовується
  static final BorderRadius radius12 = BorderRadius.circular(12);

  /* PADDINGS */

  // Пустий внутрішній відступ
  static const EdgeInsets zeroPadding = EdgeInsets.all(0.0);

  // Внутрішній відступ 10 для всіх сторін
  static const EdgeInsets allPadding10 = EdgeInsets.all(10.0);

  // Горизонтальний внутрішній відступ 8
  static const EdgeInsets horizontal8 = EdgeInsets.symmetric(horizontal: 8.0);

  // Загальний внутрішній відступ
  static const EdgeInsets commonPadding =
      EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0);

  // Мінімальний горизонтальний внутрішній відступ
  static const EdgeInsets minHorizontal =
      EdgeInsets.symmetric(vertical: 0, horizontal: 3);
}
