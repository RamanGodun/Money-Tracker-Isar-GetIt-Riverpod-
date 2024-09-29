import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'animation_controller_service.dart';
import '../../DATA/constants/app_strings.dart';
import '../../DATA/models/expense_model.dart';
import '../providers/expenses_provider.dart';
import '../providers/input_data_provider.dart';
import '../../UI/components/dialog_and_buttons/_custom_dialog.dart';
import '../../UI/pages/input_expense.dart';

/// Service class responsible for displaying a custom dialog to add or edit an expense.
/// The dialog allows users to input or update expense details (title, amount, category, date).
class ExpenseDialogService {
  /// Displays a dialog for adding a new expense or editing an existing one.
  /// If an [expenseToEdit] is provided, it pre-fills the form with the expense details.
  Future<void> showAddOrEditExpenseDialog(
    BuildContext context,
    WidgetRef ref, {
    ExpenseModel? expenseToEdit, // Optional parameter for editing an expense.
  }) async {
    // Reset the input state before showing the dialog
    ref.read(expenseInputProvider.notifier).reset();

    // If an expense is provided, pre-fill the state with its details
    if (expenseToEdit != null) {
      ref.read(expenseManagementProvider.notifier).updateExpense(
            ExpenseModel(
              id: expenseToEdit.id,
              title: expenseToEdit.title,
              amount: double.parse(expenseToEdit.amount.toString()),
              date: expenseToEdit.date,
              category: expenseToEdit.category,
            ),
          );
    }

    // Get the current theme (dark or light) for styling purposes
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    // Show a custom dialog with animations and user inputs
    showDialog(
      context: context,
      barrierColor: isDarkTheme
          ? theme.shadowColor.withOpacity(0.8)
          : theme.shadowColor.withOpacity(0.7),
      builder: (context) {
        return HookBuilder(
          builder: (context) {
            // Create an animation controller for dialog animations
            final animationController = useAnimationController(
              duration: const Duration(milliseconds: 250),
            );
            animationController.forward(); // Start the animation

            // Build a custom dialog with the form for adding or editing expenses
            return CustomDialog(
              contentWidget: NewOrEditExpense(initialExpense: expenseToEdit),
              theme: theme,
              animationService: AnimationService(
                controller: animationController,
              ),
              onActionPressed: () {
                final expenseNotifier = ref.read(expenseInputProvider.notifier);

                // Mark the form as submitted to trigger validation
                expenseNotifier.markSubmitted();

                // If the data is valid, either add a new expense or update the existing one
                if (expenseNotifier.validateData()) {
                  final expenseData = ref.read(expenseInputProvider);

                  // If editing an expense, update it
                  if (expenseToEdit != null) {
                    ref.read(expenseManagementProvider.notifier).updateExpense(
                          ExpenseModel(
                            id: expenseToEdit.id,
                            title: expenseData.title,
                            amount: double.parse(expenseData.amount),
                            date: expenseData.date!,
                            category: expenseData.category,
                          ),
                        );
                  } else {
                    // If adding a new expense, save it
                    ref.read(expenseManagementProvider.notifier).addExpense(
                          ExpenseModel(
                            title: expenseData.title,
                            amount: double.parse(expenseData.amount),
                            date: expenseData.date!,
                            category: expenseData.category,
                          ),
                        );
                  }

                  // Reverse the animation and close the dialog
                  animationController.reverse();
                  Navigator.of(context).pop();
                } else {
                  // Handle validation errors (e.g., show error messages)
                  // You could add logic here to display specific validation messages
                }
              },
              onCancelPressed: () {
                // Reverse the animation and close the dialog on cancel
                animationController.reverse();
                Navigator.of(context).pop();
              },
              dialogTitle: expenseToEdit != null
                  ? AppStrings.editExpense // Show "Edit Expense" if editing
                  : AppStrings
                      .addNewExpense, // Show "Add New Expense" if adding
              actionButtonText: AppStrings.save, // Save button text
              cancelButtonText: AppStrings.cancel, // Cancel button text
            );
          },
        );
      },
    );
  }
}
