import 'package:flutter/material.dart';
import '../../../DOMAIN/models/expense_model.dart';
import 'item_for_list.dart';

class ExpensesList extends StatelessWidget {
  final List<ExpenseModel> expenses;
  const ExpensesList({required this.expenses, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return ExpenseItemForList(expense: expense);
      },
    );
  }
}
