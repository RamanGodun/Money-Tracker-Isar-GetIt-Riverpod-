import 'category_model.dart';
import 'db_item_model.dart';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat.yMd();

class ExpenseModel {
  int id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseModel({
    this.id = -1,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  String get formattedDate => formatter.format(date);

  // Конвертація з UI-моделі в модель БД
  DBExpenseModel toDBModel() {
    return DBExpenseModel(
      title: title,
      amount: amount,
      date: date,
      category: category.name,
    );
  }

  // Фабрика для створення ExpenseModel на основі моделі з БД
  factory ExpenseModel.fromDBModel(DBExpenseModel dbExpense) {
    final category = CategoryExtension.fromName(dbExpense.category);
    return ExpenseModel(
      id: dbExpense.id,
      title: dbExpense.title,
      amount: dbExpense.amount,
      date: dbExpense.date,
      category: category,
    );
  }
}
