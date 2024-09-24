import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../DATA/constants/app_constants.dart';
import '../../../DATA/constants/app_text_styling.dart';
import '../../../DATA/providers/gen_data_provider.dart';
import '../../../DATA/themes_set/themes_provider.dart';
import '../../../DOMAIN/models/app_enums.dart';
import '../../../DOMAIN/models/expense_model.dart';
import '../../../DOMAIN/models/expenses_bucket_model.dart';
import '_chart_bar.dart';

class Chart extends ConsumerWidget {
  final List<ExpenseModel> expenses;
  final List<ExpensesBucket> buckets;
  final double maxTotalExpense;
  final List<double> categorySum1;

  Chart({super.key, required this.expenses})
      : buckets = _generateBuckets(expenses),
        maxTotalExpense = _calculateMaxTotalExpense(expenses),
        categorySum1 = _calculateCategorySum(expenses);

  // Генерація списку ExpensesBucket
  static List<ExpensesBucket> _generateBuckets(List<ExpenseModel> expenses) {
    return [
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
  }

  // Обчислення максимальної суми витрат
  static double _calculateMaxTotalExpense(List<ExpenseModel> expenses) {
    double maxTotalExpense = 0;
    final buckets = _generateBuckets(expenses);
    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  // Обчислення сум витрат по категоріям
  static List<double> _calculateCategorySum(List<ExpenseModel> expenses) {
    final buckets = _generateBuckets(expenses);
    return buckets.map((bucket) => bucket.totalExpenses).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    final generalData = ref.watch(generalDataProvider);

    final categorySum = {
      Category.food: categorySum1[0],
      Category.leisure: categorySum1[1],
      Category.transport: categorySum1[2],
      Category.work: categorySum1[3],
      Category.charity: categorySum1[4],
      Category.health: categorySum1[5],
      Category.other: categorySum1[6],
    };

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: generalData.deviceSize.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            colorScheme.secondary.withOpacity(0.3),
            colorScheme.secondary.withOpacity(0.0)
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
                for (final bucket in buckets)
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
                            color: colorScheme.secondary
                                .withOpacity(isDarkMode ? 0.8 : 0.7),
                          ),
                          StyledText.bodyMedium(
                              theme,
                              categorySum[bucket.category]
                                      ?.toStringAsFixed(0) ??
                                  '0')
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
