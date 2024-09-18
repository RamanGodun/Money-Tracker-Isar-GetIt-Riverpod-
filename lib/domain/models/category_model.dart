import 'package:flutter/material.dart';

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

enum Category { food, travel, leisure, work }

extension CategoryExtension on Category {
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
