import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DATA/models/expense_model.dart';
import '../../DATA/data_services/isar_service.dart';
import '../../DATA/models/expanses_state.dart';
import 'isar_provider.dart';

/// StateNotifierProvider that manages the state of expenses and performs CRUD (Create, Read, Update, Delete) operations on the expenses data.
///
/// This provider relies on the IsarService for database operations and initializes the
/// [ExpensesNotifier] to manage the expenses' state. It automatically loads expenses when instantiated.
final expenseManagementProvider =
    StateNotifierProvider<ExpensesNotifier, ExpensesState>((ref) {
  final isarService = ref.read(
      isarServiceProvider); // Retrieve the IsarService using Riverpod's provider system
  return ExpensesNotifier(isarService)
    ..loadExpenses(); // Automatically load expenses on initialization
});

/// StateNotifier that handles all expense-related operations such as adding, updating, removing, and loading expenses from the database.
///
/// This class extends [StateNotifier], which allows it to manage and update the [ExpensesState] in response to operations
/// performed on the expenses (e.g., CRUD operations). It uses [IsarService] to interface with the local Isar database.
class ExpensesNotifier extends StateNotifier<ExpensesState> {
  final IsarService
      _isarService; // Instance of IsarService for interacting with the database

  ExpensesNotifier(this._isarService)
      : super(ExpensesState(
            expenses: [])); // Initialize with an empty expenses list

  /// Loads all expenses from the Isar database.
  ///
  /// This method fetches all stored expenses, updates the state to indicate loading, and
  /// finally updates the state with the fetched expenses or an error message if something goes wrong.
  Future<void> loadExpenses() async {
    try {
      state = state.copyWith(isLoading: true); // Set loading state to true
      final expenses = await _isarService
          .getAllExpenses(); // Fetch all expenses from the database
      state = state.copyWith(
          expenses: expenses,
          isLoading: false); // Update state with loaded expenses
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          error: e.toString()); // Handle any errors during loading
    }
  }

  /// Adds a new expense to the Isar database and reloads the list of expenses.
  ///
  /// After adding a new expense, this method reloads all expenses to ensure the state reflects the latest data from the database.
  Future<void> addExpense(ExpenseModel expense) async {
    try {
      await _isarService.addExpense(expense); // Add new expense to the database
      loadExpenses(); // Reload expenses to reflect the new data
    } catch (e) {
      state = state.copyWith(
          error: e.toString()); // Handle any errors during the addition process
    }
  }

  /// Updates an existing expense in the Isar database and reloads the list of expenses.
  ///
  /// This method allows modifying an existing expense. Once the update is completed,
  /// the method reloads the expenses list to reflect the updated data.
  Future<void> updateExpense(ExpenseModel expense) async {
    try {
      await _isarService
          .updateExpense(expense); // Update the expense in the database
      await loadExpenses(); // Reload expenses after updating
    } catch (e) {
      state = state.copyWith(
          error: e.toString()); // Handle any errors during the update process
    }
  }

  /// Removes an expense from the Isar database and reloads the list of expenses.
  ///
  /// This method removes an expense from the database, and upon success, it reloads the expenses list
  /// to reflect the updated data.
  Future<void> removeExpense(ExpenseModel expense) async {
    try {
      await _isarService
          .deleteExpenseFromDB(expense); // Remove the expense from the database
      loadExpenses(); // Reload expenses after removal
    } catch (e) {
      state = state.copyWith(
          error: e.toString()); // Handle any errors during the removal process
    }
  }
}
