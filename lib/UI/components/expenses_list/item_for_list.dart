import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/DATA/constants/app_borders.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/themes_set/themes_provider.dart';
import '../../../DOMAIN/models/expense_model.dart';
import 'package:money_tracker/DATA/providers/expenses_provider.dart';

import '../text_widgets.dart';

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
            foregroundColor: colorScheme.primary,
            borderRadius: AppConstants.borderRadiusCommon,
            onPressed: (_) {
              // Можна додати додаткові дії
            },
            icon: Icons.settings,
          ),
          SlidableAction(
            backgroundColor: colorScheme.surface.withOpacity(0.1),
            foregroundColor: colorScheme.error,
            borderRadius: AppConstants.borderRadiusCommon,
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
        color: isDarkTheme
            ? colorScheme.inverseSurface.withOpacity(0.06)
            : colorScheme.surface.withOpacity(0.2),
        shape: AppBordersStyling.appShapeBorder(colorScheme),
        elevation: 5,
        shadowColor: theme.shadowColor.withOpacity(0.2),
        child: ListTile(
          title: StyledText.titleSmall(theme, expense.title),
          subtitle: Row(
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: StyledText.bodyMedium(
                    theme, '\$${expense.amount.toStringAsFixed(2)}'),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    categoriesIcons[expense.category],
                    color: colorScheme.secondary.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
//
                  StyledText.bodySmall(
                      theme, DateFormat('dd.MM.yyyy').format(expense.date)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
