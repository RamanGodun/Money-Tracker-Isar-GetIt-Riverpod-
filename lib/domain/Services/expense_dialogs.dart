import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/expense_model.dart';
import '../../UI/components/custom_dialog/custom_dialog.dart';
import '../../data/providers/expenses_provider.dart';
import '../../data/providers/input_data_provider.dart';
import '../../UI/pages/new_expense.dart';

class ExpenseDialogService {
  void showAddExpenseDialog({
    required BuildContext context,
    required WidgetRef ref,
    required ThemeData theme,
    required bool isDarkTheme,
  }) {
    showDialog(
      context: context,
      barrierColor:
          theme.colorScheme.shadow.withOpacity(isDarkTheme ? 0.8 : 0.74),
      builder: (context) {
        return CustomDialog(
          contentWidget: const NewExpense(),
          onActionPressed: () {
            final expenseNotifier = ref.read(newExpenseProvider.notifier);

            if (expenseNotifier.validateData()) {
              final expenseData = expenseNotifier.state;
              ref.read(expensesNotifierProvider.notifier).addExpense(
                    ExpenseModel(
                      title: expenseData.title,
                      amount: double.parse(expenseData.amount),
                      date: expenseData.date!,
                      category: expenseData.category,
                    ),
                  );
              Navigator.of(context).pop();
            }
          },
          onCancelPressed: () => Navigator.of(context).pop(),
          dialogTitle: 'Додати нову витрату',
          actionButtonText: 'Зберегти',
          cancelButtonText: 'Відміна',
        );
      },
    );
  }
}
