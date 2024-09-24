import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/DATA/constants/app_text_styling.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/themes_set/themes_provider.dart';
import '../../../DOMAIN/models/expense_model.dart';
import 'package:money_tracker/DATA/providers/expenses_provider.dart';

class ExpenseItemForList extends ConsumerWidget {
  final ExpenseModel expense;
  const ExpenseItemForList({required this.expense, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: colorScheme.surface.withOpacity(0.1),
            foregroundColor: const Color.fromARGB(255, 58, 157, 63),
            borderRadius: BorderRadius.circular(10),
            onPressed: (_) {
              // Можна додати додаткові дії
            },
            icon: Icons.settings,
          ),
          SlidableAction(
            backgroundColor: colorScheme.surface.withOpacity(0.1),
            foregroundColor: colorScheme.error,
            borderRadius: BorderRadius.circular(10),
            onPressed: (_) {
              ref
                  .read(expensesNotifierProvider.notifier)
                  .removeExpense(expense);
            },
            icon: Icons.delete,
          ),
        ],
      ),
      child: Card(
        color: colorScheme.surface.withOpacity(isDarkTheme ? 0.8 : 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        shadowColor: theme.shadowColor.withOpacity(0.2),
        child: ListTile(
          title: StyledText.titleSmall(theme, expense.title),
          subtitle: Row(
            children: [
              StyledText.bodyMedium(
                  theme, '\$${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    categoriesIcons[expense.category],
                    color: colorScheme.secondary.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  StyledText.bodySmall(theme, expense.formattedDate),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
