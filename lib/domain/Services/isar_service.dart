import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import '../models/db_item_model.dart';
import '../models/expense_model.dart';

class IsarService {
  late Isar isar;

  Future<void> initializeIsar() async {
    try {
      final dir = await getApplicationSupportDirectory();
      isar = await Isar.open([DBExpenseModelSchema], directory: dir.path);
    } catch (e) {
      // ignore: avoid_print
      print("Error initializing Isar: $e");
    }
  }

  // Отримання всіх витрат з бази даних
  Future<List<ExpenseModel>> getAllExpenses() async {
    final dbExpenses = await isar.dBExpenseModels.where().findAll();
    return dbExpenses
        .map((dbExpense) => ExpenseModel.fromDBModel(dbExpense))
        .toList();
  }

  // Додавання витрати в базу даних
  Future<void> addExpense(ExpenseModel expense) async {
    final dbExpense = expense.toDBModel();
    await isar.writeTxn(() async {
      final id = await isar.dBExpenseModels.put(dbExpense);
      // Оновлюємо ID у моделі
      expense.id = id;
    });
  }

  // Видалення витрати з бази даних
  Future<void> removeExpense(ExpenseModel expense) async {
    await isar.writeTxn(() async {
      await isar.dBExpenseModels.delete(expense.id);
    });
  }

  Future<void> closeIsar() async {
    await isar.close();
  }
}
