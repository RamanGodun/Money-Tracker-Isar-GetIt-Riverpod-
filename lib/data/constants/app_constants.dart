import 'package:flutter/material.dart';
import '../models/app_enums.dart';

/// A class to store all app-wide constants such as paddings, sizes, and styles.
/// This ensures centralized control over UI parameters and promotes consistent design.
abstract class AppConstants {
  static const double elevationCommon = 0;
  static const double heightCommon = 50;
  static const double iconSizeCommon = 28;
  static final BorderRadius borderRadiusCommon = BorderRadius.circular(12);

  /* PADDINGS */
  static const EdgeInsets allPadding0 = EdgeInsets.all(0.0);
  static const EdgeInsets allPadding10 = EdgeInsets.all(10.0);
  static const EdgeInsets paddingHorizontal18 =
      EdgeInsets.symmetric(horizontal: 18.0);
  static const EdgeInsets paddingCommon =
      EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0);
}

/// A map that corresponds to expense categories and their icons.
/// This is used to display appropriate icons based on the selected category.
const categoriesIcons = {
  Category.food: Icons.lunch_dining,
  Category.transport: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.charity: Icons.heart_broken_rounded,
  Category.health: Icons.health_and_safety_rounded,
  Category.other: Icons.settings,
};
