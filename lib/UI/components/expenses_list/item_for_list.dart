import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/expense_model.dart';
import '../../../domain/models/category_model.dart';
import 'package:money_tracker/data/providers/expenses_provider.dart';

class ExpenseItemForList extends ConsumerWidget {
  final ExpenseModel expense;
  const ExpenseItemForList({required this.expense, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.grey.withOpacity(0.1),
            foregroundColor: const Color.fromARGB(255, 58, 157, 63),
            borderRadius: BorderRadius.circular(5),
            onPressed: (_) {
              // Можна додати додаткові дії
            },
            icon: Icons.settings,
          ),
          SlidableAction(
            backgroundColor: Colors.grey.withOpacity(0.1),
            foregroundColor: Colors.red,
            borderRadius: BorderRadius.circular(5),
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
        color: Colors.grey.withOpacity(0.3),
        child: ListTile(
          title: Text(
            expense.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Row(
            children: [
              Text('\$${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                  Icon(categoriesIcons[expense.category]),
                  const SizedBox(width: 8),
                  Text(expense.formattedDate),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
