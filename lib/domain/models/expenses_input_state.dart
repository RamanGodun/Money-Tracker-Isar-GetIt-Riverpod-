import 'app_enums.dart';

class NewExpenseState {
  final String title;
  final String amount;
  final Category category;
  final DateTime? date;
  final bool isSubmitted;

  NewExpenseState({
    this.title = '',
    this.amount = '',
    this.category = Category.leisure,
    this.date,
    this.isSubmitted = false,
  });

  NewExpenseState copyWith({
    String? title,
    String? amount,
    Category? category,
    DateTime? date,
    bool? isSubmitted,
  }) {
    return NewExpenseState(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}
