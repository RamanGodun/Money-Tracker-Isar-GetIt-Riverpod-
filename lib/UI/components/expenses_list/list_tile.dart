import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../DATA/constants/app_borders.dart';
import '../../../DATA/constants/app_constants.dart';
import '../../../DOMAIN/providers/themes_provider.dart';
import '../../../DOMAIN/Services/_service_locator.dart';
import '../../../DOMAIN/Services/exp_dialog_service.dart';
import '../../../DATA/models/expense_model.dart';
import '../../../DOMAIN/providers/expenses_provider.dart';
import '../text_widgets.dart';

/// A widget that represents a single expense item in the list.
/// It supports sliding actions for editing and deleting an expense.
class ExpenseListTile extends ConsumerWidget {
  final ExpenseModel expense;

  const ExpenseListTile({required this.expense, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current theme and color scheme
    final theme = ref.watch(themeDataProvider);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    return Slidable(
      // Action pane with buttons for editing and deleting an expense
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // Slidable action for editing the expense
          SlidableAction(
            backgroundColor: colorScheme.surface.withOpacity(0.1),
            foregroundColor: colorScheme.primary,
            borderRadius: AppConstants.borderRadiusCommon,
            onPressed: (_) {
              // Open the edit expense dialog
              final dialogService =
                  AppServiceLocator.instance.get<ExpenseDialogService>();
              dialogService.showAddOrEditExpenseDialog(context, ref,
                  expenseToEdit: expense);
            },
            icon: Icons.settings,
          ),
          // Slidable action for deleting the expense
          SlidableAction(
            backgroundColor: colorScheme.surface.withOpacity(0.1),
            foregroundColor: colorScheme.error,
            borderRadius: AppConstants.borderRadiusCommon,
            onPressed: (_) {
              // Remove the expense from the list
              ref
                  .read(expenseManagementProvider.notifier)
                  .removeExpense(expense);
            },
            icon: Icons.delete,
          ),
        ],
      ),
      // The main content of the expense item (inside the card)
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Display the amount of the expense
              FittedBox(
                fit: BoxFit.fitWidth,
                child: StyledText.bodyMedium(
                    theme, '\$${expense.amount.toStringAsFixed(2)}'),
              ),
              // Display the category icon and date of the expense
              Row(
                children: [
                  Icon(
                    expenseCategoryIcons[expense.category],
                    color: colorScheme.secondary.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
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
