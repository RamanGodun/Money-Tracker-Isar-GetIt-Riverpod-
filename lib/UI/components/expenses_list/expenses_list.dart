import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../DATA/constants/app_strings.dart';
import '../../../DATA/helpers/helpers.dart';
import '../../../DATA/models/expense_model.dart';
import '../text_widgets.dart';
import 'list_tile.dart';

/// A widget that displays a list of expenses. It uses hooks to memoize the list of expense items
/// to prevent unnecessary rebuilds when the list of expenses does not change.
class ExpensesList extends HookWidget {
  final List<ExpenseModel> expensesList;

  const ExpensesList({required this.expensesList, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Helpers.getTheme(context);

    /*
      Memoizes each expense item using `useMemoized`, ensuring that the expense items are only
      rebuilt if the `expenses` list changes. This improves performance by avoiding unnecessary 
      widget rebuilds when the list remains unchanged.
    */
    final cachedExpenseItems = useMemoized(
      () => expensesList
          .map((expense) => ExpenseListTile(expense: expense))
          .toList(),
      [expensesList],
    );

    // If the expenses list is empty, display a message prompting the user to add an expense
    return expensesList.isEmpty
        ? Center(
            child: StyledText.titleSmall(
              theme,
              AppStrings.addFirstExpense,
              color: theme.colorScheme.secondary,
            ),
          )
        // If there are expenses, display them in a scrollable list
        : ListView.builder(
            itemCount: cachedExpenseItems.length,
            itemBuilder: (context, index) {
              return cachedExpenseItems[index];
            },
          );
  }
}
