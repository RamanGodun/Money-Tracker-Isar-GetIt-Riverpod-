import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import '../models/db_item_model.dart';
import '../models/expense_model.dart';

class IsarService {
  late Isar isar;

  /// Opens the Isar database and initializes the schema.
  /// This method ensures that the database is ready for use.
  Future<void> openDatabase() async {
    try {
      final dir = await getApplicationSupportDirectory();
      isar = await Isar.open([DBExpenseModelSchema], directory: dir.path);
      // Database initialized successfully
    } catch (e) {
      // Handle any error that occurs during database initialization
    }
  }

  /// Retrieves all expense records from the database.
  /// Returns a list of [ExpenseModel] sorted by the date in descending order.
  Future<List<ExpenseModel>> getAllExpenses() async {
    final dbExpenses =
        await isar.dBExpenseModels.where().sortByDateDesc().findAll();
    return dbExpenses
        .map((dbExpense) => ExpenseModel.fromDBModel(dbExpense))
        .toList();
  }

  /// Adds a new expense record to the database.
  /// Converts the [ExpenseModel] to the database model and stores it.
  /// Updates the expense ID after it is added to the database.
  Future<void> addExpense(ExpenseModel expense) async {
    final dbExpense = expense.toDBModel();
    await isar.writeTxn(() async {
      final id = await isar.dBExpenseModels.put(dbExpense);
      expense.id = id;
      // Expense added successfully with the generated ID
    });
  }

  /// Updates an existing expense record in the database.
  /// Uses the current expense ID to locate and update the record.
  Future<void> updateExpense(ExpenseModel expense) async {
    final dbExpense = expense.toDBModel();
    dbExpense.id = expense.id; // The current ID is used for the update.
    await isar.writeTxn(() async {
      await isar.dBExpenseModels.put(dbExpense);
      // Expense updated successfully
    });
  }

  /// Removes an expense record from the database by its ID.
  Future<void> deleteExpenseFromDB(ExpenseModel expense) async {
    await isar.writeTxn(() async {
      await isar.dBExpenseModels.delete(expense.id);
      // Expense removed successfully
    });
  }

  /// Closes the Isar database connection.
  /// This should be called when the database is no longer needed.
  Future<void> closeIsar() async {
    await isar.close();
    // Database connection closed
  }
}
