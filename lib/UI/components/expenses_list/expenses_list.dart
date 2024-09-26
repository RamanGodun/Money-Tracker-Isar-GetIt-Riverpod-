import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../DATA/constants/app_strings.dart';
import '../../../DATA/helpers/helpers.dart';
import '../../../DATA/models/expense_model.dart';
import '../text_widgets.dart';
import 'item_for_list.dart';

class ExpensesList extends HookWidget {
  final List<ExpenseModel> expenses;
  const ExpensesList({required this.expenses, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Helpers.getTheme(context);
/*
  Мемоізуємо кожен елемент витрат за допомогою useMemoized, 
  оновлюємо тільки при зміні списку витрат
*/
    final memoizedExpenses = useMemoized(
      () => expenses
          .map((expense) => ExpenseItemForList(expense: expense))
          .toList(),
      [expenses],
    );

    return expenses.isEmpty
        ? Center(
            child: StyledText.titleSmall(
              theme,
              AppStrings.addFirstExpense,
              color: theme.colorScheme.secondary,
            ),
          )
        : ListView.builder(
            itemCount: memoizedExpenses.length,
            itemBuilder: (context, index) {
              return memoizedExpenses[index];
            },
          );
  }
}
