import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Services/text_validation_service.dart';
import '../../DATA/models/app_enums.dart';
import '../../DATA/models/expense_model.dart';
import '../../DATA/models/expenses_input_state.dart';

/// StateNotifierProvider that manages input data for new or edited expenses.
///
/// This provider is responsible for creating an instance of [NewExpenseNotifier]
/// which holds the state and logic for handling user input when adding or editing an expense.
final expenseInputProvider =
    StateNotifierProvider<NewExpenseNotifier, NewExpenseState>(
  (ref) => NewExpenseNotifier(),
);

/// StateNotifier that manages the expense input form, handles updates to the input fields,
/// performs validation, and updates the state as necessary.
///
/// This class is responsible for managing the user input, including title, amount,
/// category, and date fields. It also validates the input data and tracks the submission state.
class NewExpenseNotifier extends StateNotifier<NewExpenseState> {
  /// Initializes the [NewExpenseNotifier] with an empty expense state.
  NewExpenseNotifier() : super(NewExpenseState());

  /// Sets the initial values for editing an existing expense.
  ///
  /// This method is useful when the user is editing an existing expense. It updates
  /// the input fields with the existing values from the provided [ExpenseModel].
  void setInitialExpense(ExpenseModel expense) {
    state = state.copyWith(
      title: expense.title,
      amount: expense.amount.toString(),
      date: expense.date,
      category: expense.category,
    );
  }

  /// Updates the title input field in the state.
  ///
  /// This method is called every time the user changes the title of the expense.
  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  /// Updates the amount input field in the state.
  ///
  /// This method is called every time the user changes the amount of the expense.
  void updateAmount(String amount) {
    state = state.copyWith(amount: amount);
  }

  /// Updates the category of the expense in the state.
  ///
  /// This method is called every time the user changes the expense category.
  void updateCategory(Category category) {
    state = state.copyWith(category: category);
  }

  /// Updates the date of the expense in the state.
  ///
  /// This method is called every time the user selects or changes the date of the expense.
  void updateDate(DateTime? date) {
    state = state.copyWith(date: date);
  }

  /// Validates the current input data.
  ///
  /// This method checks if the title, amount, and date fields have valid values.
  /// It uses the [TextFieldValidationService] to validate the title and amount.
  /// If all fields are valid, it returns `true`; otherwise, it returns `false`.
  bool validateData() {
    bool isValid = true;
    if (TextFieldValidationService.validateString(state.title, false, 3) !=
        null) {
      isValid = false;
    }
    if (TextFieldValidationService.validateDouble(state.amount, 1) != null) {
      isValid = false;
    }
    if (state.date == null) {
      isValid = false;
    }
    return isValid;
  }

  /// Marks the form as submitted.
  ///
  /// This is typically called when the user submits the form, which can trigger
  /// the display of validation errors if the input data is invalid.
  void markSubmitted() {
    state = state.copyWith(isSubmitted: true);
  }

  /// Resets the expense input form to its initial state.
  ///
  /// This method clears all the fields and resets the state to a fresh instance
  /// of [NewExpenseState], effectively clearing the form.
  void reset() {
    state = NewExpenseState();
  }

  /// Returns the validation error message for the title field, or `null` if no error exists.
  ///
  /// This method uses the [TextFieldValidationService] to check if the title is valid.
  /// It only returns an error message if the form has been marked as submitted.
  String? get titleError {
    if (!state.isSubmitted) return null;
    return TextFieldValidationService.validateString(state.title, false, 3);
  }

  /// Returns the validation error message for the amount field, or `null` if no error exists.
  ///
  /// This method uses the [TextFieldValidationService] to check if the amount is valid.
  /// It only returns an error message if the form has been marked as submitted.
  String? get amountError {
    if (!state.isSubmitted) return null;
    return TextFieldValidationService.validateDouble(state.amount, 1);
  }
}
