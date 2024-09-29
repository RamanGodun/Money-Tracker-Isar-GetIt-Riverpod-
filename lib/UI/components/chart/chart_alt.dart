import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../../../DATA/models/expense_model.dart';
import 'chart_bar_alt.dart';

/// `ChartAlt` is a widget that displays an alternative bar chart visualization of expenses.
/// It groups the expenses by the last 7 days and visualizes the amount spent on each day.
class Last7DaysChart extends HookWidget {
  final List<ExpenseModel> expenses;

  /// Constructor that requires a list of expenses.
  const Last7DaysChart(this.expenses, {super.key});

  /// Generates a list of maps, each containing a day of the week and the total amount
  /// of money spent on that day. It checks the date of each expense and groups them by day.
  List<Map<String, dynamic>> _groupExpensesByLast7Days() {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      final dailyTotalSum = expenses
          .where((expense) =>
              expense.date.day == weekDay.day &&
              expense.date.month == weekDay.month &&
              expense.date.year == weekDay.year)
          .fold(0.0, (sum, expense) => sum + expense.amount);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'spentMoney': dailyTotalSum,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    // Memoized expenses grouping for the last 7 days
    final groupedExpenses = useMemoized(_groupExpensesByLast7Days, [expenses]);

    // Total spending calculation
    final totalWeeklySpending = groupedExpenses.fold(
      0.0,
      (sum, item) => sum + (item['spentMoney'] as double? ?? 0.0),
    );

    if (expenses.isEmpty) {
      return const Card(
        child: Center(
          child: Text('No expenses to display'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: _buildChartBars(groupedExpenses, totalWeeklySpending),
      ),
    );
  }

  /// Builds the chart bars for each day of the last 7 days.
  Widget _buildChartBars(
      List<Map<String, dynamic>> groupedExpenses, double totalSpending) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: groupedExpenses.map((data) {
        final spendingRatio = totalSpending == 0.0
            ? 0.0
            : (data['spentMoney'] as double) / totalSpending;

        return Flexible(
          fit: FlexFit.loose,
          child: ChartBarAlt(
            data['day'].toString(),
            (data['spentMoney'] as double? ?? 0.0),
            spendingRatio,
          ),
        );
      }).toList(),
    );
  }
}
