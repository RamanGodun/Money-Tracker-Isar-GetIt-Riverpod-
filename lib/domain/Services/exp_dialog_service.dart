// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/DOMAIN/Services/animation_controller_service.dart';
import '../../DATA/constants/strings_4_app.dart';
import '../../DOMAIN/models/expense_model.dart';
import '../../DATA/providers/expenses_provider.dart';
import '../../DATA/providers/input_data_provider.dart';
import '../../UI/components/dialog_and_buttons/_custom_dialog.dart';
import '../../UI/pages/input_expense.dart';

class ExpenseDialogService {
  Future<void> showAddOrEditExpenseDialog(
    BuildContext context,
    WidgetRef ref, {
    ExpenseModel? expenseToEdit,
  }) async {
    print("Opening dialog...");
    ref
        .read(expensesInputDataProvider.notifier)
        .reset(); // Спочатку скидаємо стан

    if (expenseToEdit != null) {
      print("Editing expense with ID: ${expenseToEdit.id}");
      ref.read(expensesNotifierProvider.notifier).updateExpense(
            ExpenseModel(
              id: expenseToEdit.id,
              title: expenseToEdit.title,
              amount: double.parse(expenseToEdit.amount.toString()),
              date: expenseToEdit.date,
              category: expenseToEdit.category,
            ),
          );
    }

    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierColor: isDarkTheme
          ? theme.shadowColor.withOpacity(0.8)
          : theme.shadowColor.withOpacity(0.7),
      builder: (context) {
        return HookBuilder(
          builder: (context) {
            final animationController = useAnimationController(
              duration: const Duration(milliseconds: 250),
            );
            animationController.forward();

            return CustomDialog(
              contentWidget: NewOrEditExpense(initialExpense: expenseToEdit),
              theme: theme,
              animationService:
                  AnimationService(controller: animationController),
              onActionPressed: () {
                final expenseNotifier =
                    ref.read(expensesInputDataProvider.notifier);

                expenseNotifier.markSubmitted();
                print("Validating data...");

                if (expenseNotifier.validateData()) {
                  final expenseData = ref.read(expensesInputDataProvider);

                  if (expenseToEdit != null) {
                    print("Updating expense with ID: ${expenseToEdit.id}");
                    // Якщо це редагування, оновлюємо витрату
                    ref.read(expensesNotifierProvider.notifier).updateExpense(
                          ExpenseModel(
                            id: expenseToEdit.id, // Зберігаємо ID витрати
                            title: expenseData.title,
                            amount: double.parse(expenseData.amount),
                            date: expenseData.date!,
                            category: expenseData.category,
                          ),
                        );
                  } else {
                    print("Adding a new expense");
                    // Якщо це нова витрата, додаємо її
                    ref.read(expensesNotifierProvider.notifier).addExpense(
                          ExpenseModel(
                            title: expenseData.title,
                            amount: double.parse(expenseData.amount),
                            date: expenseData.date!,
                            category: expenseData.category,
                          ),
                        );
                  }

                  animationController.reverse();
                  Navigator.of(context).pop();
                } else {
                  print("Validation failed");
                }
              },
              onCancelPressed: () {
                animationController.reverse();
                Navigator.of(context).pop();
              },
              dialogTitle: expenseToEdit != null
                  ? AppStrings.editExpense
                  : AppStrings.addNewExpense,
              actionButtonText: AppStrings.save,
              cancelButtonText: AppStrings.cancel,
            );
          },
        );
      },
    );
  }
}
