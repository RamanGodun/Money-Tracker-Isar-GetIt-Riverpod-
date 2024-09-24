import 'package:flutter/material.dart';
import '../../DOMAIN/models/app_enums.dart';

abstract class AppConstants {
  static const double elevation = 0;
  static const double generalBorderRadius = 12.0;
  static const double buttonsHeight = 50;
  static const double iconSize = 28;
  static final BorderRadius commonBorderRadius =
      BorderRadius.circular(generalBorderRadius);
  static final BorderRadius radius12 = BorderRadius.circular(12);

  /* PADDINGS */
  static const EdgeInsets zeroPadding = EdgeInsets.all(0.0);
  static const EdgeInsets allPadding10 = EdgeInsets.all(10.0);
  static const EdgeInsets horizontal8 = EdgeInsets.symmetric(horizontal: 8.0);
  static const EdgeInsets commonPadding =
      EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0);
  static const EdgeInsets minHorizontal =
      EdgeInsets.symmetric(vertical: 0, horizontal: 3);
}

const categoriesIcons = {
  Category.food: Icons.lunch_dining,
  Category.transport: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.charity: Icons.heart_broken_rounded,
  Category.health: Icons.health_and_safety_rounded,
  Category.other: Icons.settings
};
