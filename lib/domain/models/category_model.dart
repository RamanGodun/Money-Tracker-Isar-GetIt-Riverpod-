import 'package:flutter/material.dart';

const categoriesIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

enum Category { food, travel, leisure, work }

extension CategoryExtension on Category {
  static Category fromName(String name) {
    switch (name) {
      case 'продукти':
        return Category.food;
      case 'транспорт':
        return Category.travel;
      case 'відпочинок':
        return Category.leisure;
      case 'робота':
        return Category.work;
      default:
        throw ArgumentError('Unknown category name');
    }
  }

  String get name {
    switch (this) {
      case Category.food:
        return 'продукти';
      case Category.travel:
        return 'транспорт';
      case Category.leisure:
        return 'відпочинок';
      case Category.work:
        return 'робота';
    }
  }
}
