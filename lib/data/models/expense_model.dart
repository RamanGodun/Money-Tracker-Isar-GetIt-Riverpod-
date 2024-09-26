import 'app_enums.dart';
import 'db_item_model.dart';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat.yMd();

class ExpenseModel {
  int id;
  String title;
  double amount;
  DateTime date;
  Category category;

  ExpenseModel({
    this.id = -1,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  // Конвертація в DB-модель
  DBExpenseModel toDBModel() {
    return DBExpenseModel(
      title: title,
      amount: amount,
      date: date,
      category: category.name,
    );
  }

  // Конвертація з DB-моделі в UI-модель
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
