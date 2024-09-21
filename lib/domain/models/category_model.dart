import 'package:flutter/material.dart';
import 'app_enums.dart';

const categoriesIcons = {
  Category.food: Icons.lunch_dining,
  Category.transport: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.charity: Icons.heart_broken_rounded,
  Category.health: Icons.health_and_safety_rounded,
  Category.other: Icons.settings
};

extension CategoryExtension on Category {
  static Category fromName(String name) {
    switch (name) {
      case 'продукти':
        return Category.food;
      case 'транспорт':
        return Category.transport;
      case 'відпочинок':
        return Category.leisure;
      case 'робота':
        return Category.work;
      case 'благодійність':
        return Category.charity;
      case 'здоров\'я':
        return Category.health;
      case 'інше':
        return Category.other;
      default:
        throw ArgumentError('Unknown category name');
    }
  }

  String get name {
    switch (this) {
      case Category.food:
        return 'продукти';
      case Category.transport:
        return 'транспорт';
      case Category.leisure:
        return 'відпочинок';
      case Category.work:
        return 'робота';
      case Category.charity:
        return 'благодійність';
      case Category.health:
        return 'здоров\'я';
      case Category.other:
        return 'інше';
    }
  }
}
