import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DOMAIN/Services/text_validation_service.dart';
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
    // Валідація назви
    if (TextFieldValidationService.validateString(state.title, false, 3) !=
        null) {
      isValid = false;
    }
    // ВTextFieldValidationService
    if (TextFieldValidationService.validateDouble(state.amount, 1) != null) {
      isValid = false;
    }
    // Валідація дати
    if (state.date == null) {
      isValid = false;
    }
    return isValid;
  }

  // Очищення полів (скидання стану до початкового)
  void reset() {
    state = NewExpenseState();
  }

  String? get titleError =>
      TextFieldValidationService.validateString(state.title, false, 3);
  String? get amountError =>
      TextFieldValidationService.validateDouble(state.amount, 1);
}
