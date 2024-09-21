import 'package:flutter/material.dart';

import '../../../domain/models/app_enums.dart';
import '../../../domain/models/category_model.dart';
import '../../../domain/models/expenses_bucket_model.dart';
import '../../../domain/models/expense_model.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<ExpenseModel> expenses;

  List<ExpensesBucket> get buckets => [
        Category.food,
        Category.leisure,
        Category.transport,
        Category.work,
        Category.charity,
        Category.health,
        Category.other
      ]
          .map((category) => ExpensesBucket.forCategory(expenses, category))
          .toList();

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  List<double> get categorySum1 =>
      buckets.map((bucket) => bucket.totalExpenses).toList();

//
  @override
  Widget build(BuildContext context) {
    //
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final categorySum = {
      Category.food: categorySum1[0],
      Category.leisure: categorySum1[1],
      Category.transport: categorySum1[2],
      Category.work: categorySum1[3],
      Category.charity: categorySum1[4],
      Category.health: categorySum1[5],
      Category.other: categorySum1[6],
    };
    //
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket
                    in buckets) // alternative to map() when inside List<Widget>
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          Icon(
                            categoriesIcons[bucket.category],
                            color: isDarkMode
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.7),
                          ),
                          Text(categorySum[bucket.category].toString()),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
