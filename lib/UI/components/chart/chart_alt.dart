import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/models/expenses_model.dart';
import 'chart_bar_alt.dart';

class ChartAlt extends StatelessWidget {
  const ChartAlt(this.recentTransactions, {super.key});
  //
  final List<ExpenseModel> recentTransactions;

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'spentMoney': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['spentMoney']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(19),
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
          )),
    );
  }
}
