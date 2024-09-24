import 'package:flutter/material.dart';

import '../../DOMAIN/models/app_enums.dart';

abstract class Constants {}

const categoriesIcons = {
  Category.food: Icons.lunch_dining,
  Category.transport: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.charity: Icons.heart_broken_rounded,
  Category.health: Icons.health_and_safety_rounded,
  Category.other: Icons.settings
};
