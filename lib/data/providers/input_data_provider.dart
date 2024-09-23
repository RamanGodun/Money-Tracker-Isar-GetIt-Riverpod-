import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DOMAIN/models/app_enums.dart';

final newExpenseProvider =
    StateNotifierProvider<NewExpenseNotifier, NewExpenseState>(
  (ref) => NewExpenseNotifier(),
);

class NewExpenseNotifier extends StateNotifier<NewExpenseState> {
  NewExpenseNotifier() : super(NewExpenseState());

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateAmount(String amount) {
    state = state.copyWith(amount: amount);
  }

  void updateCategory(Category category) {
    state = state.copyWith(category: category);
  }

  void updateDate(DateTime? date) {
    state = state.copyWith(date: date);
  }

  bool validateData() {
    bool isValid = true;
    if (state.title.isEmpty || state.amount.isEmpty || state.date == null) {
      isValid = false;
    }
    return isValid;
  }

  NewExpenseState getExpenseData() {
    return state;
  }
}

class NewExpenseState {
  final String title;
  final String amount;
  final Category category;
  final DateTime? date;

  NewExpenseState({
    this.title = '',
    this.amount = '',
    this.category = Category.leisure,
    this.date,
  });

  NewExpenseState copyWith({
    String? title,
    String? amount,
    Category? category,
    DateTime? date,
  }) {
    return NewExpenseState(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
    );
  }
}
