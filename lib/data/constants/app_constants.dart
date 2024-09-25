import 'package:flutter/material.dart';
import '../../DOMAIN/models/app_enums.dart';

abstract class AppConstants {
  static const double elevationCommon = 0;
  static const double heightForComponent = 50;
  static const double iconSizeStandard = 28;
  static final BorderRadius borderRadiusCommon = BorderRadius.circular(12);

  /* PADDINGS */
  static const EdgeInsets allPadding0 = EdgeInsets.all(0.0);
  static const EdgeInsets allPadding10 = EdgeInsets.all(10.0);
  static const EdgeInsets paddingHorizontal8 =
      EdgeInsets.symmetric(horizontal: 8.0);
  static const EdgeInsets paddingCommon =
      EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0);
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
