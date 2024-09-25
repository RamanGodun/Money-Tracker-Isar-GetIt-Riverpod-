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
    DateTime? date,
    this.isSubmitted = false,
  }) : date = date ?? DateTime.now(); // дата за замовчуванням

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
