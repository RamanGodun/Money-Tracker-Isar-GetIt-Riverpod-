/*
Here all enums for this app
 */
enum ValidatorType {
  integer,
  double,
  string,
  name,
  email,
  phoneNumber,
  sameAs,
}

enum DialogButtonType {
  actionButtonInIOSStyle,
  actionButtonInAndroidStyle,
  cancelButtonInIOSStyle,
  cancelButtonInAndroidType
}

enum Category {
  food,
  transport,
  leisure,
  work,
  charity,
  health,
  other,
}

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
