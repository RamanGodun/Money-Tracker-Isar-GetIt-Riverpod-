import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/expense_model.dart';
import '../../domain/Services/isar_service.dart';
import '../../domain/models/expanses_state.dart';
import 'isar_provider.dart';

// Провайдер для ExpensesNotifier
final expensesNotifierProvider =
    StateNotifierProvider<ExpensesNotifier, ExpensesState>((ref) {
  final isarService = ref.read(isarServiceProvider);
  return ExpensesNotifier(isarService)..loadExpenses();
});

class ExpensesNotifier extends StateNotifier<ExpensesState> {
  final IsarService _isarService;

  ExpensesNotifier(this._isarService) : super(ExpensesState(expenses: []));

  Future<void> loadExpenses() async {
    try {
      state = state.copyWith(isLoading: true);
      final expenses = await _isarService.getAllExpenses();
      state = state.copyWith(expenses: expenses, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addExpense(ExpenseModel expense) async {
    try {
      await _isarService.addExpense(expense);
      loadExpenses(); // Перезавантажуємо список після додавання
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> removeExpense(ExpenseModel expense) async {
    try {
      await _isarService.removeExpense(expense);
      loadExpenses();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
