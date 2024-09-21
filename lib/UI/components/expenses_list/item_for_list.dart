import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/helpers/helpers.dart';
import '../../../domain/models/expense_model.dart';
import '../../../domain/models/category_model.dart';
import 'package:money_tracker/data/providers/expenses_provider.dart';

class ExpenseItemForList extends ConsumerWidget {
  final ExpenseModel expense;
  const ExpenseItemForList({required this.expense, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    bool isDarkTheme = Helpers.isDarkTheme(theme);

    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: theme.colorScheme.surface.withOpacity(0.1),
            foregroundColor: const Color.fromARGB(255, 58, 157, 63),
            borderRadius: BorderRadius.circular(10),
            onPressed: (_) {
              // Можна додати додаткові дії
            },
            icon: Icons.settings,
          ),
          SlidableAction(
            backgroundColor: theme.colorScheme.surface.withOpacity(0.1),
            foregroundColor: theme.colorScheme.error,
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
        color: theme.colorScheme.surface.withOpacity(isDarkTheme ? 0.8 : 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        shadowColor: theme.shadowColor.withOpacity(0.2),
        child: ListTile(
          title: Text(
            expense.title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                '\$${expense.amount.toStringAsFixed(2)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    categoriesIcons[expense.category],
                    color: theme.colorScheme.primary.withOpacity(0.8),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    expense.formattedDate,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
