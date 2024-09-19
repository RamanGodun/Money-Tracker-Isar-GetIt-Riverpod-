import 'category_model.dart';
import 'expense_model.dart';

class ExpensesBucket {
  const ExpensesBucket({
    required this.category,
    required this.expenses,
  });
  // additional-alternative Constructor
  ExpensesBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<ExpenseModel> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
