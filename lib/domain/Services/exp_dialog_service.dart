import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/DOMAIN/Services/animation_controller_service.dart';
import '../../DATA/constants/strings_4_app.dart';
import '../../DOMAIN/models/expense_model.dart';
import '../../DATA/providers/expenses_provider.dart';
import '../../DATA/providers/input_data_provider.dart';
import '../../UI/components/dialog_and_buttons/custom_dialog.dart';
import '../../UI/pages/new_expense.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExpenseDialogService {
  Future<void> showAddExpenseDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
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
              contentWidget: const NewExpense(),
              theme: theme,
              animationService:
                  AnimationService(controller: animationController),
              onActionPressed: () {
                final expenseNotifier =
                    ref.read(expensesInputDataProvider.notifier);

                // Використовуємо getExpenseData для доступу до даних
                final expenseData = expenseNotifier.getExpenseData();
                if (expenseNotifier.validateData()) {
                  ref.read(expensesNotifierProvider.notifier).addExpense(
                        ExpenseModel(
                          title: expenseData.title,
                          amount: double.parse(expenseData.amount),
                          date: expenseData.date!,
                          category: expenseData.category,
                        ),
                      );
                  animationController.reverse();
                  Navigator.of(context).pop();
                }
              },
              onCancelPressed: () {
                animationController.reverse();
                Navigator.of(context).pop();
              },
              dialogTitle: AppStrings.addNewExpense,
              actionButtonText: AppStrings.save,
              cancelButtonText: AppStrings.cancel,
            );
          },
        );
      },
    );
  }
}
