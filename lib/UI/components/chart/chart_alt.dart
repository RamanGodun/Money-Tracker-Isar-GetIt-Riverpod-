import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import '../../../DATA/models/expense_model.dart';
import 'chart_bar_alt.dart';

class ChartAlt extends HookWidget {
  final List<ExpenseModel> expenses;
  const ChartAlt(this.expenses, {super.key});

  List<Map<String, dynamic>> _generateGroupedTransactionValues() {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < expenses.length; i++) {
        if (expenses[i].date.day == weekDay.day &&
            expenses[i].date.month == weekDay.month &&
            expenses[i].date.year == weekDay.year) {
          totalSum += expenses[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'spentMoney': totalSum,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    // Мемоізуємо дані для графіка
    final groupedTransactionValues = useMemoized(
      () => _generateGroupedTransactionValues(),
      [expenses],
    );

    final totalSpending = groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['spentMoney'] ?? 0.0);
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.loose,
              child: ChartBarAlt(
                data['day'].toString(),
                (data['spentMoney'] as double? ?? 0.0),
                totalSpending == 0.0
                    ? 0.0
                    : (data['spentMoney'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
