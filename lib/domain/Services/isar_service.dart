// ignore_for_file: avoid_print

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
      print("Isar initialized");
    } catch (e) {
      print("Error initializing Isar: $e");
    }
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    print("Fetching all expenses...");
    final dbExpenses =
        await isar.dBExpenseModels.where().sortByDateDesc().findAll();
    return dbExpenses
        .map((dbExpense) => ExpenseModel.fromDBModel(dbExpense))
        .toList();
  }

  Future<void> addExpense(ExpenseModel expense) async {
    final dbExpense = expense.toDBModel();
    await isar.writeTxn(() async {
      final id = await isar.dBExpenseModels.put(dbExpense);
      expense.id = id;
      print("Added expense with ID: $id");
    });
  }

  Future<void> updateExpenseItemOnDB(ExpenseModel expense) async {
    final dbExpense = expense.toDBModel();
    dbExpense.id = expense.id; // Використовуємо поточний ID для оновлення
    await isar.writeTxn(() async {
      await isar.dBExpenseModels.put(dbExpense); // Оновлюємо витрату в БД
      print("Оновлено витрату з ID: ${dbExpense.id}");
    });
  }

  Future<void> removeExpense(ExpenseModel expense) async {
    print("Removing expense with ID: ${expense.id}");
    await isar.writeTxn(() async {
      await isar.dBExpenseModels.delete(expense.id);
      print("Expense removed");
    });
  }

  Future<void> closeIsar() async {
    await isar.close();
    print("Isar closed");
  }
}
