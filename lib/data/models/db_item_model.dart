import 'package:isar/isar.dart';
// dart run build_runner build

part 'db_item_model.g.dart';

@Collection()
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
