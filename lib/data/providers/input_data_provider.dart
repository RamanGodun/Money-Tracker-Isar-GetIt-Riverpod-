import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DOMAIN/models/app_enums.dart';
import '../../DOMAIN/models/expenses_input_state.dart';

final expensesInputDataProvider =
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
