import 'package:isar/isar.dart';

part 'db_item_model.g.dart';

@Collection()
class DBExpenseModel {
  Id id = Isar.autoIncrement;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  DBExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}
