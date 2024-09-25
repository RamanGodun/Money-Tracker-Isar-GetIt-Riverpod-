import 'package:flutter/material.dart';
import '../../../DATA/constants/strings_4_app.dart';
import '../../../DATA/helpers/helpers.dart';
import '../../../DOMAIN/models/expense_model.dart';
import '../text_widgets.dart';
import 'item_for_list.dart';

class ExpensesList extends StatelessWidget {
  final List<ExpenseModel> expenses;
  const ExpensesList({required this.expenses, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Helpers.themeGet(context);

    return expenses.isEmpty
        ? Center(
            child: StyledText.titleSmall(theme, AppStrings.addFirstExpense,
                color: theme.colorScheme.secondary),
          )
        : ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return ExpenseItemForList(expense: expense);
            },
          );
  }
}
