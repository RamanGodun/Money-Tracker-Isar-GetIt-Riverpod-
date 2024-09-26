import 'expense_model.dart';

class ExpensesState {
  final List<ExpenseModel> expenses;
  final bool isLoading;
  final String? error;

  ExpensesState({
    required this.expenses,
    this.isLoading = false,
    this.error,
  });

  ExpensesState copyWith({
    List<ExpenseModel>? expenses,
    bool? isLoading,
    String? error,
  }) {
    return ExpensesState(
      expenses: expenses ?? this.expenses,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
